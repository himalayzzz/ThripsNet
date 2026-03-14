import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';

class LeafDiseasePrediction {
  final String label;
  final double confidence;
  final List<String> symptoms;
  final String recommendation;

  const LeafDiseasePrediction({
    required this.label,
    required this.confidence,
    required this.symptoms,
    required this.recommendation,
  });
}

class LeafDiseaseClassifier {
  static const String _modelPath = 'assets/tswv_best_model.tflite';
  static const String _labelsPath = 'assets/thrips_class.txt';
  static const String _modelPathBackslash = 'assets\\tswv_best_model.tflite';
  static const String _labelsPathBackslash = 'assets\\thrips_class.txt';

  static final LeafDiseaseClassifier instance = LeafDiseaseClassifier._();

  LeafDiseaseClassifier._();

  Interpreter? _interpreter;
  List<String>? _labels;

  Future<void> _loadIfNeeded() async {
    if (_interpreter != null && _labels != null) {
      return;
    }

    _interpreter = await _loadInterpreterWithFallback();
    final String labelsRaw = await _loadLabelsWithFallback();
    _labels = labelsRaw
        .split('\n')
        .map((String line) => line.trim())
        .where((String line) => line.isNotEmpty)
        .toList(growable: false);
  }

  Future<Interpreter> _loadInterpreterWithFallback() async {
    try {
      return await Interpreter.fromAsset(_modelPath);
    } catch (_) {
      return Interpreter.fromAsset(_modelPathBackslash);
    }
  }

  Future<String> _loadLabelsWithFallback() async {
    try {
      return await rootBundle.loadString(_labelsPath);
    } catch (_) {
      return rootBundle.loadString(_labelsPathBackslash);
    }
  }

  Future<LeafDiseasePrediction> classifyImage(File imageFile) async {
    await _loadIfNeeded();

    final Interpreter interpreter = _interpreter!;
    final List<String> labels = _labels!;

    final Uint8List bytes = await imageFile.readAsBytes();
    final img.Image? original = img.decodeImage(bytes);
    if (original == null) {
      throw Exception('Unable to decode selected image.');
    }

    final Tensor inputTensor = interpreter.getInputTensor(0);
    final List<int> inputShape = inputTensor.shape;
    if (inputShape.length != 4 || inputShape[0] != 1 || inputShape[3] != 3) {
      throw Exception('Unsupported model input shape: $inputShape');
    }

    final int inputHeight = inputShape[1];
    final int inputWidth = inputShape[2];
    final img.Image resized = img.copyResize(
      original,
      width: inputWidth,
      height: inputHeight,
      interpolation: img.Interpolation.linear,
    );

    final Object input = _buildInputBuffer(
      resized: resized,
      inputHeight: inputHeight,
      inputWidth: inputWidth,
      inputParams: inputTensor.params,
      inputType: inputTensor.type,
    );

    final List<Tensor> outputTensors = interpreter.getOutputTensors();
    if (outputTensors.isEmpty) {
      throw Exception('Model has no output tensors.');
    }

    final Map<int, Object> outputs = <int, Object>{};
    for (int i = 0; i < outputTensors.length; i++) {
      final Tensor tensor = outputTensors[i];
      outputs[i] = _buildOutputBuffer(outputShape: tensor.shape, outputType: tensor.type);
    }

    interpreter.runForMultipleInputs([input], outputs);

    final _OutputSelection selected = _selectBestOutput(
      outputs: outputs,
      outputTensors: outputTensors,
      labelCount: labels.length,
    );

    if (selected.scores.isEmpty) {
      throw Exception('Selected output tensor produced no class scores.');
    }

    final int usableCount = math.min(selected.scores.length, labels.length);
    final List<double> usableScores = selected.scores.take(usableCount).toList(growable: false);
    final int topIndex = _argMax(usableScores);
    final String label = topIndex < labels.length ? labels[topIndex] : 'Unknown';

    final _ScoreInterpretation interpretation = _interpretScores(usableScores);
    final double confidence = interpretation.confidence;

    // Helpful runtime telemetry when diagnosing model/output mismatches.
    debugPrint(
      'Leaf model output tensor ${selected.tensorIndex} shape=${selected.tensor.shape} '
      'type=${selected.tensor.type} scores=${selected.scores.length} labels=${labels.length} '
      'top=$label conf=${(confidence * 100).toStringAsFixed(2)}%',
    );

    return LeafDiseasePrediction(
      label: label,
      confidence: confidence,
      symptoms: _inferSymptoms(label),
      recommendation: _recommendationForLabel(label),
    );
  }

  _OutputSelection _selectBestOutput({
    required Map<int, Object> outputs,
    required List<Tensor> outputTensors,
    required int labelCount,
  }) {
    _OutputSelection? best;

    for (int i = 0; i < outputTensors.length; i++) {
      final Tensor tensor = outputTensors[i];
      final List<double> scores = _extractScores(
        output: outputs[i]!,
        outputType: tensor.type,
        outputParams: tensor.params,
      );

      final int scoreCount = scores.length;
      final bool exactMatch = scoreCount == labelCount;
      final bool lastDimMatch = tensor.shape.isNotEmpty && tensor.shape.last == labelCount;
      final int distance = (scoreCount - labelCount).abs();

      final _OutputSelection candidate = _OutputSelection(
        tensorIndex: i,
        tensor: tensor,
        scores: scores,
        priority: exactMatch
            ? 3
            : (lastDimMatch ? 2 : (labelCount > 0 ? (distance <= 2 ? 1 : 0) : 0)),
        distance: distance,
      );

      if (best == null) {
        best = candidate;
        continue;
      }

      if (candidate.priority > best.priority ||
          (candidate.priority == best.priority && candidate.distance < best.distance)) {
        best = candidate;
      }
    }

    return best!;
  }

  Object _buildInputBuffer({
    required img.Image resized,
    required int inputHeight,
    required int inputWidth,
    required QuantizationParams inputParams,
    required TensorType inputType,
  }) {
    if (inputType == TensorType.uint8) {
      return <List<List<List<int>>>>[
        List<List<List<int>>>.generate(
          inputHeight,
          (int y) => List<List<int>>.generate(
            inputWidth,
            (int x) {
              final img.Pixel pixel = resized.getPixel(x, y);
              return <int>[pixel.r.toInt(), pixel.g.toInt(), pixel.b.toInt()];
            },
            growable: false,
          ),
          growable: false,
        ),
      ];
    }

    if (inputType == TensorType.int8) {
      final double scale = inputParams.scale == 0 ? 1.0 : inputParams.scale;
      final int zeroPoint = inputParams.zeroPoint;

      return <List<List<List<int>>>>[
        List<List<List<int>>>.generate(
          inputHeight,
          (int y) => List<List<int>>.generate(
            inputWidth,
            (int x) {
              final img.Pixel pixel = resized.getPixel(x, y);
              return <int>[
                _quantizeInt8(pixel.r / 255.0, scale, zeroPoint),
                _quantizeInt8(pixel.g / 255.0, scale, zeroPoint),
                _quantizeInt8(pixel.b / 255.0, scale, zeroPoint),
              ];
            },
            growable: false,
          ),
          growable: false,
        ),
      ];
    }

    if (inputType != TensorType.float32) {
      throw Exception('Unsupported model input type: $inputType');
    }

    return <List<List<List<double>>>>[
      List<List<List<double>>>.generate(
        inputHeight,
        (int y) => List<List<double>>.generate(
          inputWidth,
          (int x) {
            final img.Pixel pixel = resized.getPixel(x, y);
            return <double>[
              pixel.r / 255.0,
              pixel.g / 255.0,
              pixel.b / 255.0,
            ];
          },
          growable: false,
        ),
        growable: false,
      ),
    ];
  }

  Object _buildOutputBuffer({required List<int> outputShape, required TensorType outputType}) {
    if (outputType == TensorType.uint8 || outputType == TensorType.int8) {
      return _buildNestedIntBuffer(outputShape);
    }
    if (outputType != TensorType.float32) {
      throw Exception('Unsupported model output type: $outputType');
    }
    return _buildNestedDoubleBuffer(outputShape);
  }

  List<double> _extractScores({
    required Object output,
    required TensorType outputType,
    required QuantizationParams outputParams,
  }) {
    if (outputType == TensorType.uint8) {
      final List<int> flat = <int>[];
      _flattenInts(output, flat);
      return flat.map((int value) => value.toDouble()).toList(growable: false);
    }

    if (outputType == TensorType.int8) {
      final List<int> flat = <int>[];
      _flattenInts(output, flat);
      final double scale = outputParams.scale == 0 ? 1.0 : outputParams.scale;
      final int zeroPoint = outputParams.zeroPoint;
      return flat.map((int value) => (value - zeroPoint) * scale).toList(growable: false);
    }

    final List<double> flat = <double>[];
    _flattenDoubles(output, flat);
    return flat;
  }

  Object _buildNestedIntBuffer(List<int> shape) {
    return _buildNestedBuffer<int>(shape, 0, 0);
  }

  Object _buildNestedDoubleBuffer(List<int> shape) {
    return _buildNestedBuffer<double>(shape, 0, 0.0);
  }

  Object _buildNestedBuffer<T extends num>(List<int> shape, int depth, T fillValue) {
    final int dim = shape[depth];
    if (depth == shape.length - 1) {
      return List<T>.filled(dim, fillValue, growable: false);
    }

    return List<Object>.generate(
      dim,
      (_) => _buildNestedBuffer<T>(shape, depth + 1, fillValue),
      growable: false,
    );
  }

  void _flattenInts(Object value, List<int> out) {
    if (value is int) {
      out.add(value);
      return;
    }
    if (value is List) {
      for (final Object child in value) {
        _flattenInts(child, out);
      }
    }
  }

  void _flattenDoubles(Object value, List<double> out) {
    if (value is num) {
      out.add(value.toDouble());
      return;
    }
    if (value is List) {
      for (final Object child in value) {
        _flattenDoubles(child, out);
      }
    }
  }

  int _quantizeInt8(double normalizedValue, double scale, int zeroPoint) {
    final int quantized = (normalizedValue / scale + zeroPoint).round();
    if (quantized < -128) {
      return -128;
    }
    if (quantized > 127) {
      return 127;
    }
    return quantized;
  }

  List<double> _toProbabilities(List<double> scores) {
    if (scores.isEmpty) {
      throw Exception('Model returned empty output.');
    }

    final double minScore = scores.reduce(math.min);
    final double maxScore = scores.reduce(math.max);
    final double sumScores = scores.fold<double>(0.0, (double acc, double value) => acc + value);

    if (minScore >= 0 && maxScore <= 1.0 && sumScores > 0) {
      return scores.map((double value) => value / sumScores).toList(growable: false);
    }

    final double maxLogit = maxScore;
    final List<double> exps = scores.map((double value) => math.exp(value - maxLogit)).toList(growable: false);
    final double sumExps = exps.fold<double>(0.0, (double acc, double value) => acc + value);
    if (sumExps == 0) {
      throw Exception('Model output could not be normalized.');
    }

    return exps.map((double value) => value / sumExps).toList(growable: false);
  }

  _ScoreInterpretation _interpretScores(List<double> scores) {
    final double minScore = scores.reduce(math.min);
    final double maxScore = scores.reduce(math.max);

    // For sigmoid-style outputs already in [0,1], use direct top score.
    if (minScore >= 0 && maxScore <= 1.0) {
      final int topIndex = _argMax(scores);
      final double confidence = scores[topIndex].clamp(0.0, 1.0);
      return _ScoreInterpretation(confidence: confidence);
    }

    final List<double> probabilities = _toProbabilities(scores);
    final int topIndex = _argMax(probabilities);
    final double confidence = probabilities[topIndex];
    return _ScoreInterpretation(confidence: confidence);
  }

  int _argMax(List<double> values) {
    int bestIndex = 0;
    for (int i = 1; i < values.length; i++) {
      if (values[i] > values[bestIndex]) {
        bestIndex = i;
      }
    }
    return bestIndex;
  }

  List<String> _inferSymptoms(String label) {
    final String lowered = label.toLowerCase();

    if (lowered.contains('healthy')) {
      return const <String>[
        'No major visible disease symptoms detected.',
        'Leaf texture and color pattern appear consistent with healthy foliage.',
      ];
    }
    if (lowered.contains('bacterial spot')) {
      return const <String>[
        'Small dark water-soaked spots on leaves.',
        'Spots may turn brown-black with yellow halo.',
      ];
    }
    if (lowered.contains('early blight')) {
      return const <String>[
        'Brown concentric ring lesions (target-like spots).',
        'Yellowing around lesions on older leaves.',
      ];
    }
    if (lowered.contains('late blight')) {
      return const <String>[
        'Irregular dark-green or brown lesions.',
        'Rapid spread of leaf blight under humid conditions.',
      ];
    }
    if (lowered.contains('leaf mold')) {
      return const <String>[
        'Yellow patches on upper leaf surface.',
        'Olive-green to gray mold growth underneath leaves.',
      ];
    }
    if (lowered.contains('septoria')) {
      return const <String>[
        'Numerous small circular spots with dark margins.',
        'Tiny black fruiting dots in lesion centers.',
      ];
    }
    if (lowered.contains('spider mites')) {
      return const <String>[
        'Speckled yellow stippling on leaves.',
        'Fine webbing around leaf veins or undersides.',
      ];
    }
    if (lowered.contains('target spot')) {
      return const <String>[
        'Circular brown lesions with concentric rings.',
        'Lesion expansion and leaf yellowing around spots.',
      ];
    }
    if (lowered.contains('yellow leaf curl')) {
      return const <String>[
        'Upward leaf curling and yellowing.',
        'Reduced leaf size and stunted plant growth.',
      ];
    }
    if (lowered.contains('mosaic virus')) {
      return const <String>[
        'Light and dark green mosaic pattern on leaves.',
        'Leaf distortion and irregular blade shape.',
      ];
    }

    return const <String>[
      'General stress pattern detected.',
      'Inspect nearby leaves and stem for progression signs.',
    ];
  }

  String _recommendationForLabel(String label) {
    final String lowered = label.toLowerCase();
    if (lowered.contains('healthy')) {
      return 'Plant appears healthy. Continue regular monitoring and balanced nutrient/water management.';
    }

    return 'Likely disease symptoms detected. Isolate severely affected leaves, monitor nearby plants, and follow disease-specific control practices.';
  }
}

class _OutputSelection {
  final int tensorIndex;
  final Tensor tensor;
  final List<double> scores;
  final int priority;
  final int distance;

  const _OutputSelection({
    required this.tensorIndex,
    required this.tensor,
    required this.scores,
    required this.priority,
    required this.distance,
  });
}

class _ScoreInterpretation {
  final double confidence;

  const _ScoreInterpretation({required this.confidence});
}
