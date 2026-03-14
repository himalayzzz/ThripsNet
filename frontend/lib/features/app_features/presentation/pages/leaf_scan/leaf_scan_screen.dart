import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../common/leaf_disease_classifier.dart';
import '../../../../../common/app_theme.dart';
import '../detection_result/detection_result_screen.dart';

class LeafScanScreen extends StatefulWidget {
  const LeafScanScreen({super.key});

  @override
  State<LeafScanScreen> createState() => _LeafScanScreenState();
}

class _LeafScanScreenState extends State<LeafScanScreen> {
  final ImagePicker _picker = ImagePicker();
  final LeafDiseaseClassifier _classifier = LeafDiseaseClassifier.instance;
  String? _selectedSource;
  String? _selectedInput;
  XFile? _selectedImage;

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? picked = await _picker.pickImage(
        source: source,
        imageQuality: 90,
      );

      if (picked == null || !mounted) {
        return;
      }

      setState(() {
        _selectedImage = picked;
        _selectedInput = source == ImageSource.camera ? 'camera' : 'gallery';
        _selectedSource = source == ImageSource.camera
            ? 'Captured image selected: ${picked.name}'
            : 'Uploaded image selected: ${picked.name}';
      });
    } catch (_) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not open camera/gallery. Please allow app permissions in settings.'),
        ),
      );
    }
  }

  Widget _sourceCard({
    required String title,
    required String subtitle,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: selected ? AppColors.softBlue : AppColors.white,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: selected ? AppColors.blue : AppColors.borderSoft,
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
            const SizedBox(height: 4),
            Text(subtitle, style: const TextStyle(fontSize: 14.5, color: AppColors.textMuted, height: 1.35)),
          ],
        ),
      ),
    );
  }

  Future<void> _runDetection() async {
    if (_selectedImage == null) {
      return;
    }

    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          title: const Text('Processing'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('Analyzing leaf image...'),
              SizedBox(height: 8),
              Text('Running AI model...'),
            ],
          ),
        );
      },
    );

    try {
      final LeafDiseasePrediction prediction = await _classifier.classifyImage(File(_selectedImage!.path));
      if (!mounted) {
        return;
      }

      Navigator.of(context).pop();
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => DetectionResultScreen(
            prediction: prediction,
          ),
        ),
      );
    } catch (error, stackTrace) {
      debugPrint('Leaf model evaluation failed: $error');
      debugPrintStack(stackTrace: stackTrace);
      if (!mounted) {
        return;
      }

      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Model evaluation failed: $error'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scan Crop Leaf', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800))),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFB9E9CD), Color(0xFFE8F7EE)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(28),
            ),
            child: const Column(
              children: [
                Icon(Icons.eco_outlined, size: 94, color: AppColors.mintDeep),
                SizedBox(height: 12),
                Text(
                  'Run AI leaf analysis in seconds',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
                ),
                SizedBox(height: 6),
                Text(
                  'Capture or upload a crop leaf to identify visible disease patterns quickly.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15.5, color: AppColors.textMuted, height: 1.4),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Text('Choose Input Source', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 24)),
          const SizedBox(height: 4),
          Text('Select how you want to provide the image for analysis.', style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 15.5)),
          const SizedBox(height: 10),
          _sourceCard(
            title: 'Capture Image',
            subtitle: 'Use the camera for a fresh scan directly from the field.',
            selected: _selectedInput == 'camera',
            onTap: () {
              _pickImage(ImageSource.camera);
            },
          ),
          const SizedBox(height: 10),
          _sourceCard(
            title: 'Upload Image',
            subtitle: 'Choose an existing image and let the model inspect it.',
            selected: _selectedInput == 'gallery',
            onTap: () {
              _pickImage(ImageSource.gallery);
            },
          ),
          const SizedBox(height: 12),
          if (_selectedImage != null) ...[
            Container(
              height: 170,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.borderSoft),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(19),
                child: Image.file(
                  File(_selectedImage!.path),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.borderSoft),
            ),
            child: Text(
              _selectedSource ?? 'No image selected',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
            ),
          ),
          const SizedBox(height: 14),
          FilledButton(
            onPressed: _selectedImage == null ? null : _runDetection,
            child: const Text('Detect Disease', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
          ),
        ],
      ),
    );
  }
}
