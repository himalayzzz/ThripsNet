import 'package:flutter/material.dart';

import 'app_copy.dart';
import 'app_language.dart';
import 'app_route_observer.dart';
import 'app_tts_service.dart';

typedef VoiceTextBuilder = String Function(BuildContext context);

class PageVoiceButton extends StatefulWidget {
  const PageVoiceButton({super.key, required this.textBuilder});

  static Future<void> stopAnySpeaking() async {
    final Future<void> Function()? stopper = _activeStopper;
    if (stopper != null) {
      await stopper();
    }
  }

  static Future<void> Function()? _activeStopper;

  final VoiceTextBuilder textBuilder;

  @override
  State<PageVoiceButton> createState() => _PageVoiceButtonState();
}

class _PageVoiceButtonState extends State<PageVoiceButton> with RouteAware {
  final AppTtsService _ttsService = AppTtsService();
  AppLanguageController? _languageController;
  ModalRoute<dynamic>? _subscribedRoute;
  AppLanguage _lastLanguage = AppLanguage.english;
  bool _isSpeaking = false;
  int _speakRequestId = 0;

  @override
  void initState() {
    super.initState();
    _ttsService.init();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final ModalRoute<dynamic>? route = ModalRoute.of(context);
    if (!identical(route, _subscribedRoute)) {
      if (_subscribedRoute is PageRoute<dynamic>) {
        appRouteObserver.unsubscribe(this);
      }
      _subscribedRoute = route;
      if (route is PageRoute<dynamic>) {
        appRouteObserver.subscribe(this, route);
      }
    }

    final AppLanguageController controller = AppLanguageScope.controllerOf(
      context,
    );
    if (!identical(_languageController, controller)) {
      _languageController?.removeListener(_onLanguageChanged);
      _languageController = controller;
      _lastLanguage = controller.language;
      _languageController?.addListener(_onLanguageChanged);
    }
  }

  @override
  void didPushNext() {
    _stopSpeaking();
  }

  void _onLanguageChanged() {
    final AppLanguage current = _languageController?.language ?? _lastLanguage;
    if (current == _lastLanguage) {
      return;
    }
    _lastLanguage = current;
    _stopSpeaking();
  }

  Future<void> _stopSpeaking() async {
    _speakRequestId++;
    await _ttsService.stop();
    if (identical(PageVoiceButton._activeStopper, _stopSpeaking)) {
      PageVoiceButton._activeStopper = null;
    }
    if (!mounted) {
      return;
    }
    setState(() {
      _isSpeaking = false;
    });
  }

  Future<void> _toggleSpeak() async {
    if (_isSpeaking) {
      await _stopSpeaking();
      return;
    }

    final AppCopy copy = AppCopy.of(context);
    final AppLanguage language = AppLanguageScope.languageOf(context);
    final String text = widget.textBuilder(context).trim();
    if (text.isEmpty) {
      return;
    }

    final int requestId = ++_speakRequestId;
    PageVoiceButton._activeStopper = _stopSpeaking;
    setState(() {
      _isSpeaking = true;
    });

    final AppTtsSpeakResult result = await _ttsService.speak(
      text: text,
      appLanguageCode: language.code,
    );

    if (!mounted || requestId != _speakRequestId) {
      return;
    }

    if (!result.started) {
      setState(() {
        _isSpeaking = false;
      });
      if (identical(PageVoiceButton._activeStopper, _stopSpeaking)) {
        PageVoiceButton._activeStopper = null;
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(copy.couldNotStartVoice)));
      return;
    }

    if (mounted) {
      setState(() {
        _isSpeaking = false;
      });
    }
  }

  @override
  void dispose() {
    if (_subscribedRoute is PageRoute<dynamic>) {
      appRouteObserver.unsubscribe(this);
    }
    _languageController?.removeListener(_onLanguageChanged);
    _ttsService.stop();
    if (identical(PageVoiceButton._activeStopper, _stopSpeaking)) {
      PageVoiceButton._activeStopper = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppCopy copy = AppCopy.of(context);

    return IconButton(
      tooltip: _isSpeaking ? copy.stopAudio : copy.listen,
      onPressed: _toggleSpeak,
      icon: Icon(_isSpeaking ? Icons.mic_off_rounded : Icons.mic_rounded),
    );
  }
}
