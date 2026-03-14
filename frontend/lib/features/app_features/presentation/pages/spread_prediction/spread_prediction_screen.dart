import 'package:flutter/material.dart';

import '../../../../../common/app_theme.dart';
import '../alert_notification/alert_notification_screen.dart';

class SpreadPredictionScreen extends StatelessWidget {
  const SpreadPredictionScreen({super.key});

  Widget _legendItem({required Color color, required String text}) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(99),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.textPrimary),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Spread Prediction',
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
                colors: [Color(0xFF71CFC0), Color(0xFFA7E3D8)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(28),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x2271BFB3),
                  blurRadius: 24,
                  offset: Offset(0, 12),
                ),
              ],
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'AI Spread Forecast',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 25),
                ),
                SizedBox(height: 8),
                Text(
                  'Prediction combines detected infection point and wind flow to estimate nearby risk zones.',
                  style: TextStyle(color: Color(0xFFF0FFFB), fontWeight: FontWeight.w600, fontSize: 15.5, height: 1.35),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Card(
            color: AppColors.softBlue,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFB9EAD3), Color(0xFFD9F5E7)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: AppColors.blue.withValues(alpha: 0.18)),
                    ),
                    child: Stack(
                      children: [
                        const Center(
                          child: Icon(Icons.map_outlined, size: 64, color: Color(0x6A3DAA77)),
                        ),
                        Positioned(
                          left: 88,
                          top: 92,
                          child: Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: const Color(0xFFD9493F),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 62,
                          top: 66,
                          child: Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              color: const Color(0x38F39C36),
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: const Color(0xB8E6952B)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  _legendItem(color: Color(0xFFD9493F), text: 'Infection origin point'),
                  const SizedBox(height: 6),
                  _legendItem(color: Color(0xFFE6952B), text: '10 km high-risk spread zone'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Wind Direction', style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.textMuted)),
                        SizedBox(height: 4),
                        Text('North-East', style: TextStyle(fontWeight: FontWeight.w800, color: AppColors.textPrimary, fontSize: 17)),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Wind Speed', style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.textMuted)),
                        SizedBox(height: 4),
                        Text('14 km/h', style: TextStyle(fontWeight: FontWeight.w800, color: AppColors.textPrimary, fontSize: 17)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Card(
            child: Padding(
              padding: EdgeInsets.all(14),
              child: Text(
                'Farmers in this zone will receive alert notifications.',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(height: 14),
          FilledButton.icon(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const AlertNotificationScreen()),
              );
            },
            icon: const Icon(Icons.notification_add_rounded),
            label: const Text(
              'Send Alert',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16.5),
            ),
          ),
        ],
      ),
    );
  }
}
