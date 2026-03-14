// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:frontend/common/app_language.dart';
import 'package:frontend/main.dart';

void main() {
  testWidgets('ThripsNet home screen renders', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    final AppLanguageController controller = await AppLanguageController.load();

    await tester.pumpWidget(ThripsNetApp(languageController: controller));

    expect(find.text('THRIPSNET'), findsOneWidget);
    expect(find.text('Start Now'), findsOneWidget);
  });
}
