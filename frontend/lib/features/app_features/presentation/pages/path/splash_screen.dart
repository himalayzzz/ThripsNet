import 'package:flutter/material.dart';

import '../../../../../common/app_copy.dart';
import '../../../../../common/app_language.dart';
import '../../../../../common/page_voice_button.dart';
import '../../../../../common/app_theme.dart';
import '../dashboard/dashboard_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToDashboard();
  }

  Future<void> _navigateToDashboard() async {
    await Future<void>.delayed(const Duration(seconds: 3));
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const DashboardScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppCopy copy = AppCopy.of(context);

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFD5E7DB), Color(0xFFE6F1E9), Color(0xFFF8FCF9)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                right: 0,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    PageVoiceButton(
                      textBuilder: (BuildContext context) {
                        final AppCopy copy = AppCopy.of(context);
                        return '${copy.appName}. '
                            '${copy.aiFarmAssistant}. '
                            '${copy.splashHeadline}. '
                            '${copy.splashSubtitle}. '
                            '${copy.splashFeature}. '
                            '${copy.loading}. '
                            '${copy.startNow}.';
                      },
                    ),
                    LanguageToggleButton(tooltip: copy.changeLanguageTooltip),
                  ],
                ),
              ),
              Positioned(
                top: -50,
                right: -20,
                child: Container(
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(
                    color: const Color(0x2558C98A),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
              Positioned(
                bottom: -40,
                left: -20,
                child: Container(
                  width: 160,
                  height: 160,
                  decoration: BoxDecoration(
                    color: const Color(0x227ACFBE),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0x1D2E7B5F),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: const Text(
                        'THRIPSNET',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0x2958C98A),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        copy.aiFarmAssistant,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      copy.splashHeadline,
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(fontSize: 36, height: 1.05),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      copy.splashSubtitle,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.textMuted,
                      ),
                    ),
                    const SizedBox(height: 18),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: AppColors.borderSoft),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.auto_awesome_rounded,
                            color: AppColors.mintDeep,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              copy.splashFeature,
                              style: const TextStyle(
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.w600,
                                height: 1.35,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Expanded(
                          child: LinearProgressIndicator(
                            minHeight: 8,
                            borderRadius: BorderRadius.all(
                              Radius.circular(999),
                            ),
                            value: 0.72,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.green,
                            ),
                            backgroundColor: AppColors.white,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          copy.loading,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            color: AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    FilledButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (_) => const DashboardScreen(),
                          ),
                        );
                      },
                      child: Text(copy.startNow),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
