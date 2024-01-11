import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project_study/login_screen.dart';

void main() {
  testWidgets("Login screen has the correct widgets", (widgetTester) async {
    await widgetTester.pumpWidget(
      const MaterialApp(
        home: LoginScreen(),
      ),
    );

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
