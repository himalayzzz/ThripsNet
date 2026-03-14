import 'package:flutter/material.dart';

import '../../../../../common/app_theme.dart';
import '../../../../../common/leaf_disease_classifier.dart';
import '../spread_prediction/spread_prediction_screen.dart';

class DetectionResultScreen extends StatelessWidget {
  final LeafDiseasePrediction prediction;

  const DetectionResultScreen({
    super.key,
    required this.prediction,
  });

  String get _riskLevel {
    if (prediction.label.toLowerCase().contains('healthy')) {
      return 'Low';
    }
    if (prediction.confidence >= 0.8) {
      return 'High';
    }
    if (prediction.confidence >= 0.6) {
      return 'Moderate';
    }
    return 'Needs manual verification';
  }

  String get _displayDiagnosis {
    if (prediction.label.toLowerCase().contains('healthy')) {
      return 'No Disease Found';
    }
    return 'TSWV Found';
  }

  Widget _statTile({required String label, required String value, required IconData icon}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderSoft),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.softBlue,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppColors.mintDeep, size: 20),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.textMuted)),
                const SizedBox(height: 2),
                Text(value, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: AppColors.textPrimary)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detection Result',
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
                colors: [Color(0xFF5FCB91), Color(0xFF9BDFBE)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(28),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x2554BE89),
                  blurRadius: 24,
                  offset: Offset(0, 12),
                ),
              ],
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'AI Detection Complete',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 25),
                ),
                SizedBox(height: 8),
                Text(
                  'The model has identified likely infection markers and generated spread-risk context.',
                  style: TextStyle(color: Color(0xFFF2FFF8), fontWeight: FontWeight.w600, fontSize: 15.5, height: 1.35),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Card(
            color: AppColors.softGreen,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Model Prediction',
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _displayDiagnosis,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                  ),
                  const SizedBox(height: 12),
                  LinearProgressIndicator(
                    value: prediction.confidence,
                    minHeight: 10,
                    borderRadius: BorderRadius.circular(999),
                    backgroundColor: AppColors.white,
                    valueColor: const AlwaysStoppedAnimation<Color>(AppColors.green),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Confidence: ${(prediction.confidence * 100).toStringAsFixed(1)}%',
                    style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                  ),
                  const SizedBox(height: 12),
                  _statTile(
                    label: 'Detected Symptoms',
                    value: prediction.symptoms.join(' | '),
                    icon: Icons.visibility_rounded,
                  ),
                  const SizedBox(height: 10),
                  _statTile(
                    label: 'Risk Level',
                    value: _riskLevel,
                    icon: Icons.warning_amber_rounded,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Recommendation: ${prediction.recommendation}',
                style: const TextStyle(fontWeight: FontWeight.w600, height: 1.4),
              ),
            ),
          ),
          const SizedBox(height: 14),
          FilledButton.icon(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const SpreadPredictionScreen()),
              );
            },
            icon: const Icon(Icons.map_rounded),
            label: const Text(
              'Predict Spread',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16.5),
            ),
          ),
        ],
      ),
    );
  }
}
