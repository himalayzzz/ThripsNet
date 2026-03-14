import 'package:flutter/material.dart';

import 'common/app_theme.dart';
import 'features/app_features/presentation/pages/path/splash_screen.dart';

void main() {
  runApp(const ThripsNetApp());
}

class ThripsNetApp extends StatelessWidget {
  const ThripsNetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ThripsNet',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      home: const SplashScreen(),
    );
  }
}
