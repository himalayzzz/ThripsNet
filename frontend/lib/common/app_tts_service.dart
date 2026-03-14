import 'package:flutter_tts/flutter_tts.dart';

class AppTtsSpeakResult {
  final bool started;
  final String languageLabel;

  const AppTtsSpeakResult({required this.started, required this.languageLabel});
}

class AppTtsService {
  final FlutterTts _tts = FlutterTts();
  bool _initialized = false;

  Future<void> init() async {
    if (_initialized) {
      return;
    }

    await _tts.awaitSpeakCompletion(true);
    await _tts.setQueueMode(0);
    await _tts.setSpeechRate(0.45);
    await _tts.setVolume(1.0);
    await _tts.setPitch(1.0);

    _initialized = true;
  }

  String _mapLanguageCode(String appLanguageCode) {
    switch (appLanguageCode) {
      case 'kn':
        return 'kn-IN';
      case 'ml':
        return 'ml-IN';
      case 'hi':
        return 'hi-IN';
      case 'en':
      default:
        return 'en-IN';
    }
  }

  String _labelFromLocale(String locale) {
    if (locale.startsWith('kn')) {
      return 'Kannada';
    }
    if (locale.startsWith('ml')) {
      return 'Malayalam';
    }
    if (locale.startsWith('hi')) {
      return 'Hindi';
    }
    return 'English';
  }

  Future<String> _resolveLocale(String preferredLocale) async {
    final String preferredLanguage = preferredLocale.split('-').first;
    final List<String> candidates = <String>[
      preferredLocale,
      preferredLanguage,
      'en-IN',
      'en-US',
      'en-GB',
    ];

    for (final String locale in candidates.toSet()) {
      try {
        final dynamic available = await _tts.isLanguageAvailable(locale);
        final bool isAvailable = available == true || available == 1;
        if (isAvailable) {
          return locale;
        }
      } catch (_) {
        // Ignore and continue trying fallbacks.
      }
    }

    return 'en-US';
  }

  Future<AppTtsSpeakResult> speak({
    required String text,
    required String appLanguageCode,
  }) async {
    await init();
    await _tts.stop();

    final String preferredLocale = _mapLanguageCode(appLanguageCode);
    final String resolvedLocale = await _resolveLocale(preferredLocale);

    try {
      final dynamic languageResult = await _tts.setLanguage(resolvedLocale);
      final bool languageSet = languageResult == null || languageResult == true || languageResult == 1;
      if (!languageSet) {
        return const AppTtsSpeakResult(started: false, languageLabel: 'English');
      }

      final dynamic speakResult = await _tts.speak(text);
      final bool started = !(speakResult is int && speakResult == 0);

      return AppTtsSpeakResult(
        started: started,
        languageLabel: _labelFromLocale(resolvedLocale),
      );
    } catch (_) {
      return const AppTtsSpeakResult(started: false, languageLabel: 'English');
    }
  }

  Future<void> stop() async {
    await _tts.stop();
  }
}
