import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project_study/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:project_study/router.dart';

void main() {
  testWidgets("Visitor sees the login screen when he is not logged in",
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
    final containerWithImage = find.byType(Container).first;
    final containerWidget = widgetTester.widget<Container>(containerWithImage);
    final image = ((containerWidget.decoration as BoxDecoration?)?.image?.image
            as AssetImage?)
        ?.assetName;

    expect(find.text("Parlas"), findsOneWidget);
    expect(emailField, findsOneWidget);
    expect(passwordField, findsOneWidget);
    expect(loginButton, findsOneWidget);
    expect(image, "lib/images/login_background.jpg");
  });
}
