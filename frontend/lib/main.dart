import 'package:flutter/material.dart';

import 'common/app_language.dart';
import 'common/app_route_observer.dart';
import 'common/app_theme.dart';
import 'features/app_features/presentation/pages/path/splash_screen.dart';
import 'services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.initialize();
  final AppLanguageController languageController =
      await AppLanguageController.load();
  runApp(ThripsNetApp(languageController: languageController));
}

class ThripsNetApp extends StatelessWidget {
  const ThripsNetApp({super.key, required this.languageController});

  final AppLanguageController languageController;

  @override
  Widget build(BuildContext context) {
    return AppLanguageScope(
      controller: languageController,
      child: AnimatedBuilder(
        animation: languageController,
        builder: (BuildContext context, Widget? child) {
          return MaterialApp(
            title: 'ThripsNet',
            debugShowCheckedModeBanner: false,
            theme: buildAppTheme(),
            navigatorObservers: <NavigatorObserver>[appRouteObserver],
            home: child,
          );
        },
        child: const SplashScreen(),
      ),
    );
  }
}
