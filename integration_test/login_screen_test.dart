import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:project_study/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('end-to-end test', () {
    testWidgets('Visitor logs in and sees the home screen',
        (widgetTester) async {
      await widgetTester.pumpWidget(const MainApp());
      await widgetTester.pumpAndSettle();

      final emailField = find.widgetWithText(TextFormField, 'Email');
      final passwordField = find.widgetWithText(TextFormField, 'Password');
      final loginButton = find.widgetWithText(ElevatedButton, 'Login');

      await widgetTester.enterText(emailField, "gustavo@email.com");
      await widgetTester.enterText(passwordField, "password");
      await widgetTester.tap(loginButton);
      await widgetTester.pump();
      final circularProgress = find
          .byWidgetPredicate((widget) => widget is CircularProgressIndicator);

      expect(circularProgress, findsOneWidget);
      await widgetTester.pumpAndSettle();
      expect(circularProgress, findsNothing);
      expect(find.text("Home Screen"), findsOneWidget);
    });

    testWidgets('User imediately sees the home screen when logged in',
        (widgetTester) async {
      await widgetTester.pumpWidget(const MainApp());

      expect(find.text("Home Screen"), findsOneWidget);
    });

    testWidgets('User logs out and sees the login screen',
        (widgetTester) async {
      await widgetTester.pumpWidget(const MainApp());

      final logoutButton = find.widgetWithText(ElevatedButton, 'Logout');
      await widgetTester.tap(logoutButton);
      await widgetTester.pump();
      final circularProgress = find
          .byWidgetPredicate((widget) => widget is CircularProgressIndicator);
      expect(circularProgress, findsOneWidget);
      await widgetTester.pumpAndSettle();
      expect(find.text("Parlas"), findsOneWidget);
      expect(circularProgress, findsNothing);
    });
  });
}
