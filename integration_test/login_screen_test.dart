import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:project_study/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:project_study/router.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('end-to-end test', () {
    AuthProvider authProviderGlobal = AuthProvider();
    testWidgets('Visitor logs in and sees the home screen',
        (widgetTester) async {
      final authProvider = AuthProvider();
      await widgetTester.pumpWidget(MultiProvider(
          providers: [
            ChangeNotifierProvider<AuthProvider>(create: (_) => authProvider),
          ],
          child: MaterialApp.router(
            routerConfig: router,
          )));

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
      expect(find.text("Home Screen"), findsOneWidget);

      authProviderGlobal = AuthProvider().from(authProvider);
    });

    testWidgets('User imediately sees the home screen when logged in',
        (widgetTester) async {
      final authProvider = AuthProvider().from(authProviderGlobal);
      await widgetTester.pumpWidget(MultiProvider(
          providers: [
            ChangeNotifierProvider<AuthProvider>(create: (_) => authProvider),
          ],
          child: MaterialApp.router(
            routerConfig: router,
          )));

      expect(find.text("Home Screen"), findsOneWidget);
    });
  });
}