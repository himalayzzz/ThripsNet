import 'package:flutter/material.dart';

void main() {
  runApp(const ThripsNetApp());
}

class ThripsNetApp extends StatelessWidget {
  const ThripsNetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ThripsNet',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2E7D32)),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ThripsNet Mobile')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'AI Crop Health Monitoring',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 12),
            const Text(
              'Use this app to detect thrips and crop diseases, view wind-risk forecasts, and receive alerts.',
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: () {},
              child: const Text('Start Detection'),
            ),
          ],
        ),
      ),
    );
  }
}
