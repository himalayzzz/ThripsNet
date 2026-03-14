import 'dart:io';

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
  final interpreter = _interpreter!;
  final labels = _labels!;

  // 1. Decode and Preprocess Image
  final Uint8List bytes = await imageFile.readAsBytes();
  final img.Image? original = img.decodeImage(bytes);
  if (original == null) throw Exception('Unable to decode image.');

  // Get input requirements from the model
  final Tensor inputTensor = interpreter.getInputTensor(0);
  final int inputHeight = inputTensor.shape[1]; // 640
  final int inputWidth = inputTensor.shape[2];  // 640

  img.Image resized = img.copyResize(original, width: inputWidth, height: inputHeight);

  // 2. Build Input Buffer (Normalized 0.0 to 1.0 for Float32)
  // YOLOv8 standard: [1, 640, 640, 3]
  var input = List.generate(1, (b) => 
    List.generate(inputHeight, (y) => 
      List.generate(inputWidth, (x) {
        final pixel = resized.getPixel(x, y);
        return [pixel.r / 255.0, pixel.g / 255.0, pixel.b / 255.0];
      })
    )
  );

  // 3. Prepare Output Buffer
  // Based on your log: shape=[1, 14, 8400]
  // 14 columns = 4 box coords + 10 class scores
  final int numClasses = labels.length;
  final int numPredictions = 8400;
  var output = List.filled(1 * 14 * numPredictions, 0.0).reshape([1, 14, numPredictions]);

  // 4. Run Inference
  interpreter.run(input, output);

  // 5. YOLOv8 Post-Processing: Transpose and Search
  // The output shape is [1, 14, 8400]. We need to find the highest score.
  // It's more efficient to iterate through the predictions and find the max score for each.
  double highestConf = 0.0;
  int bestClassIdx = -1;
  
  // Transpose the output for easier processing from [1, 14, 8400] to [1, 8400, 14]
  var transposedOutput = List.generate(1, (b) => 
    List.generate(numPredictions, (i) => 
      List.generate(numClasses + 4, (j) => output[0][j][i])
    )
  );

  for (int i = 0; i < numPredictions; i++) {
    // The first 4 elements are box coordinates, the next 10 are class scores.
    // Find the max score among the class scores for this prediction.
    double maxScoreInPrediction = 0;
    int classIdxInPrediction = -1;

    for (int j = 0; j < numClasses; j++) {
      double currentScore = transposedOutput[0][i][j + 4];
      if (currentScore > maxScoreInPrediction) {
        maxScoreInPrediction = currentScore;
        classIdxInPrediction = j;
      }
    }

    // If the max score in this prediction is the highest we've seen so far, update.
    if (maxScoreInPrediction > highestConf) {
      highestConf = maxScoreInPrediction;
      bestClassIdx = classIdxInPrediction;
    }
  }

  // 6. Handle Null/Low Detections
  if (bestClassIdx == -1 || highestConf < 0.15) {
    return LeafDiseasePrediction(
      label: 'Healthy / No Disease Detected',
      confidence: highestConf,
      symptoms: ['No significant viral markers found.'],
      recommendation: 'Monitor plant daily for changes.',
    );
  }

  String finalLabel = labels[bestClassIdx];

  // 7. TSWV Breach Logic
  // Group similar viral symptoms into a Breach Alert if over 60%
  bool isVirusRisk = [
    'Tomato mosaic virus', 
    'Tomato Yellow Leaf Curl Virus', 
    'Bacterial spot'
  ].contains(finalLabel);

  bool isBreach = isVirusRisk && highestConf >= 0.60;

  debugPrint('Detection Result: $finalLabel | Conf: ${(highestConf * 100).toStringAsFixed(2)}%');

  return LeafDiseasePrediction(
    label: isBreach ? "🚨 TSWV BREACH DETECTED" : finalLabel,
    confidence: highestConf,
    symptoms: _inferSymptoms(finalLabel),
    recommendation: isBreach 
        ? "IMMEDIATE ACTION: Isolate plant and notify neighborhood farmers."
        : _recommendationForLabel(finalLabel),
  );
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
