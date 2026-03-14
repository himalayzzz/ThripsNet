import 'package:flutter/material.dart';

import '../../../../../common/app_theme.dart';
import '../disease_info/disease_info_screen.dart';
import '../leaf_scan/leaf_scan_screen.dart';
import '../seed_scan/seed_scan_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  Widget _infoPill(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: const Color(0x24FFFFFF),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: const Color(0x2EFFFFFF)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 13,
        ),
      ),
    );
  }

  Widget _actionTile({
    required BuildContext context,
    required String title,
    required String subtitle,
    required String tag,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: EdgeInsets.zero,
      color: AppColors.white,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.softBlue,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  tag,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 11,
                    color: AppColors.mintDeep,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.w800, fontSize: 22, height: 1.05),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14.5, height: 1.3),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Tap to continue',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: AppColors.textMuted,
                    ),
                  ),
                  Text(
                    'Open',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 15,
                      color: AppColors.blue,
                    ),
                  ),
                ],
              ),
            ],
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
          'Good Morning',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(14, 6, 14, 16),
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF59C987), Color(0xFF8DDBB4)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(28),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x2052BC88),
                  blurRadius: 24,
                  offset: Offset(0, 14),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _infoPill('AI FIELD GUIDE'),
                    const SizedBox(width: 8),
                    _infoPill('LIVE INSIGHTS'),
                  ],
                ),
                const SizedBox(height: 14),
                Text(
                  'Welcome Farmer',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 30,
                      ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Let us focus on healthy crops today.',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: const Color(0xFFF3FFF9), fontSize: 16.5, height: 1.35),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Location: Idukki',
                  style: TextStyle(
                    color: Color(0xFFF3FFF9),
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'Humidity 71% | Temp 29 C',
                  style: TextStyle(
                    color: Color(0xFFE9FFF4),
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  height: 8,
                  width: 140,
                  decoration: BoxDecoration(
                    color: const Color(0x3DFFFFFF),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 92,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Quick Actions',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            'Choose an AI-assisted workflow for detection and prevention.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 15.5),
          ),
          const SizedBox(height: 12),
          GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 0.98,
            children: [
              _actionTile(
                context: context,
                title: 'Scan Leaf',
                subtitle: 'Capture leaf image and run AI detection.',
                tag: 'DETECTION',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const LeafScanScreen()),
                  );
                },
              ),
              _actionTile(
                context: context,
                title: 'Scan Seed',
                subtitle: 'Capture seed image and check health indicators.',
                tag: 'QUALITY',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const SeedScanScreen(),
                    ),
                  );
                },
              ),
              _actionTile(
                context: context,
                title: 'View Alerts',
                subtitle: 'See latest field warnings and updates.',
                tag: 'MONITOR',
                onTap: () {},
              ),
              Card(
                margin: EdgeInsets.zero,
                color: AppColors.white,
                child: Padding(
                  padding: EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.softYellow,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: const Text(
                          'WEATHER',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 11,
                            color: AppColors.textPrimary,
                            letterSpacing: 0.4,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Weather',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 20,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text('Wind: North-East', style: TextStyle(fontSize: 14.5, height: 1.25)),
                      const Text('Temp: 29 C', style: TextStyle(fontSize: 14.5, height: 1.25)),
                      const Text('Humidity: 71%', style: TextStyle(fontSize: 14.5, height: 1.25)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          OutlinedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const DiseaseInfoScreen()),
              );
            },
            child: const Text(
              'Explore Disease Prevention',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
            ),
          ),
        ],
      ),
    );
  }
}
