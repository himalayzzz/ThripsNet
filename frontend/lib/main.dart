import 'package:flutter/material.dart';

import 'common/app_theme.dart';
import 'features/app_features/presentation/pages/path/splash_screen.dart';
import 'services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.initialize();
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
