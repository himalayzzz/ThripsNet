import 'package:flutter/material.dart';

import '../../../../../common/app_theme.dart';
import '../disease_info/disease_info_screen.dart';

class AlertNotificationScreen extends StatelessWidget {
  const AlertNotificationScreen({super.key});

  Widget _metaChip({required IconData icon, required String label}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0x28FFFFFF),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: const Color(0x45FFFFFF)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Colors.white),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 12.5,
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
          'Alert Notification',
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
                colors: [Color(0xFFE0AB56), Color(0xFFF1D78A)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(28),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x2CCB9E4A),
                  blurRadius: 26,
                  offset: Offset(0, 14),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.warning_amber_rounded, color: Colors.white, size: 30),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'ThripsNet High Risk Alert',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          height: 1.05,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  'TSWV detected near your farm. Prompt intervention is recommended to reduce spread.',
                  style: TextStyle(
                    color: Color(0xFFFEF8E9),
                    fontWeight: FontWeight.w600,
                    fontSize: 15.5,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 14),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _metaChip(icon: Icons.air_rounded, label: 'North-East Wind'),
                    _metaChip(icon: Icons.radar_rounded, label: 'Risk Radius 10 km'),
                    _metaChip(icon: Icons.notifications_active_rounded, label: 'Zone Alerts Active'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'AI Guidance',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
                  ),
                  SizedBox(height: 8),
                  Text('• Risk notifications are now sent to farmers in the surrounding zone.'),
                  SizedBox(height: 4),
                  Text('• Recommend immediate preventive action in border rows first.'),
                  SizedBox(height: 4),
                  Text('• Open disease guide for language-specific treatment steps.'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          FilledButton.icon(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const DiseaseInfoScreen()),
              );
            },
            style: FilledButton.styleFrom(backgroundColor: AppColors.green),
            icon: const Icon(Icons.menu_book_rounded),
            label: const Text(
              'Open Preventive Measures',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16.5),
            ),
          ),
        ],
      ),
    );
  }
}
