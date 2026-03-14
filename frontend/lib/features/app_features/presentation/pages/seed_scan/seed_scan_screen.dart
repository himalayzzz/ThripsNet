import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../common/app_theme.dart';
import '../../../../../common/leaf_disease_classifier.dart';
import '../detection_result/detection_result_screen.dart';

class SeedScanScreen extends StatefulWidget {
  const SeedScanScreen({super.key});

  @override
  State<SeedScanScreen> createState() => _SeedScanScreenState();
}

class _SeedScanScreenState extends State<SeedScanScreen> {
  final ImagePicker _picker = ImagePicker();
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
            ? 'Captured seed image selected: ${picked.name}'
            : 'Uploaded seed image selected: ${picked.name}';
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
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          title: const Text('Processing'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Analyzing seed image...'),
              SizedBox(height: 8),
              Text('Running AI model...'),
            ],
          ),
        );
      },
    );

    await Future<void>.delayed(const Duration(seconds: 2));
    if (!mounted) {
      return;
    }

    Navigator.of(context).pop();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const DetectionResultScreen(
          prediction: LeafDiseasePrediction(
            label: 'Seed quality model not configured',
            confidence: 0.0,
            symptoms: <String>['No seed classifier configured for this flow yet.'],
            recommendation: 'Connect a dedicated seed model for accurate seed condition predictions.',
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Scan Seed',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFBAEACF), Color(0xFFE7F7ED)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(28),
            ),
            child: const Column(
              children: [
                Icon(Icons.grain_outlined, size: 96, color: AppColors.mintDeep),
                SizedBox(height: 12),
                Text(
                  'Scan seed quality with AI support',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Check seed condition using a captured or uploaded image before planting.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15.5, color: AppColors.textMuted, height: 1.4),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Text('Choose Input Source', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 24)),
          const SizedBox(height: 4),
          Text('Provide an image and let the model inspect seed quality cues.', style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 15.5)),
          const SizedBox(height: 10),
          _sourceCard(
            title: 'Capture Seed Image',
            subtitle: 'Open the camera and scan the seed sample instantly.',
            selected: _selectedInput == 'camera',
            onTap: () {
              _pickImage(ImageSource.camera);
            },
          ),
          const SizedBox(height: 10),
          _sourceCard(
            title: 'Upload Seed Image',
            subtitle: 'Use an existing photo for quick AI-assisted evaluation.',
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
              _selectedSource ?? 'No seed image selected',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
            ),
          ),
          const SizedBox(height: 14),
          FilledButton(
            onPressed: _selectedImage == null ? null : _runDetection,
            child: const Text(
              'Detect Seed Condition',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
            ),
          ),
        ],
      ),
    );
  }
}
