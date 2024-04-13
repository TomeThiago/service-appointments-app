import 'package:app/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app/screens/sign_in.dart';
import 'package:app/service/auth.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart'; // Import Firebase core

void main() {
  setUpAll(() async {
    await Firebase.initializeApp();
  });

  testWidgets('Sign in screen UI test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: MultiProvider(
          providers: [
            // Provide AuthServiceProvider
            Provider<AuthServiceProvider>(
              create: (_) => AuthServiceProvider(),
            ),
          ],
          child: const SignIn(),
        ),
      ),
    );

    // Verify that the UI components are rendered correctly.
    expect(find.text('Entre na plataforma'), findsOneWidget);
    expect(find.text('E-mail'), findsOneWidget);
    expect(find.text('Senha'), findsOneWidget);
    expect(find.text('Entrar'), findsOneWidget);
    expect(find.text('Não tem uma conta?'), findsOneWidget);
    expect(find.text('Criar conta'), findsOneWidget);

    // Enter text into email and password fields.
    await tester.enterText(
        find.byType(TextFormField).at(0), 'example@example.com');
    await tester.enterText(find.byType(TextFormField).at(1), 'password');

    // Tap the obscure text button to reveal password.
    await tester.tap(find.byIcon(Icons.visibility));
    await tester.pump();

    // Verify that password is revealed.
    expect(find.text('password'), findsOneWidget);

    // Tap the 'Entrar' button and wait for navigation.
    await tester.tap(find.text('Entrar'));
    await tester.pumpAndSettle();

    // Verify that navigation occurs when 'Entrar' button is tapped.
    expect(find.byType(Home), findsOneWidget);
  });
}
