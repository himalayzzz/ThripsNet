import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

typedef OnLanguageChanging =
    Future<void> Function(
      AppLanguage previousLanguage,
      AppLanguage nextLanguage,
    );

enum AppLanguage {
  english('en', 'English', 'EN'),
  hindi('hi', 'हिन्दी', 'HI'),
  malayalam('ml', 'മലയാളം', 'ML'),
  kannada('kn', 'ಕನ್ನಡ', 'KN');

  const AppLanguage(this.code, this.nativeName, this.shortLabel);

  final String code;
  final String nativeName;
  final String shortLabel;

  static AppLanguage fromCode(String? code) {
    return AppLanguage.values.firstWhere(
      (AppLanguage language) => language.code == code,
      orElse: () => AppLanguage.english,
    );
  }
}

class AppLanguageController extends ChangeNotifier {
  AppLanguageController._(this._language);

  static const String _preferenceKey = 'app_language_code';

  AppLanguage _language;

  AppLanguage get language => _language;

  static Future<AppLanguageController> load() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? code = preferences.getString(_preferenceKey);
    return AppLanguageController._(AppLanguage.fromCode(code));
  }

  Future<void> setLanguage(AppLanguage language) async {
    if (_language == language) {
      return;
    }

    _language = language;
    notifyListeners();

    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(_preferenceKey, language.code);
  }
}

class AppLanguageScope extends InheritedNotifier<AppLanguageController> {
  const AppLanguageScope({
    super.key,
    required AppLanguageController controller,
    required super.child,
  }) : super(notifier: controller);

  static AppLanguageController controllerOf(BuildContext context) {
    final AppLanguageScope? scope = context
        .dependOnInheritedWidgetOfExactType<AppLanguageScope>();
    assert(scope != null, 'AppLanguageScope is missing from the widget tree.');
    return scope!.notifier!;
  }

  static AppLanguage languageOf(BuildContext context) {
    return controllerOf(context).language;
  }
}

class LanguageToggleButton extends StatelessWidget {
  const LanguageToggleButton({
    super.key,
    this.tooltip = 'Change language',
    this.onLanguageChanging,
  });

  final String tooltip;
  final OnLanguageChanging? onLanguageChanging;

  @override
  Widget build(BuildContext context) {
    final AppLanguageController controller = AppLanguageScope.controllerOf(
      context,
    );
    final AppLanguage current = controller.language;

    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: PopupMenuButton<AppLanguage>(
        tooltip: tooltip,
        onSelected: (AppLanguage selected) async {
          if (selected == current) {
            return;
          }

          if (onLanguageChanging != null) {
            await onLanguageChanging!(current, selected);
          }

          await controller.setLanguage(selected);
        },
        itemBuilder: (BuildContext context) {
          return AppLanguage.values
              .where((AppLanguage language) => language != current)
              .map(
                (AppLanguage language) => PopupMenuItem<AppLanguage>(
                  value: language,
                  child: Row(
                    children: [
                      Text(
                        language.shortLabel,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(width: 8),
                      Text(language.nativeName),
                    ],
                  ),
                ),
              )
              .toList();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFFEAF4FF),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0x4D2F80ED)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.translate_rounded,
                size: 16,
                color: Color(0xFF2F80ED),
              ),
              const SizedBox(width: 6),
              Text(
                current.shortLabel,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2F80ED),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
