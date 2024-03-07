import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobil_final_odev/SourceCodes/LoginPage.dart';

void main() {
  testWidgets('SignInPage widget test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: SignInPage(),
        ),
      ),
    );

    // Verify if the necessary widgets are present in the widget tree.
    expect(find.byType(TextField), findsNWidgets(2));
    expect(find.byType(ElevatedButton), findsOneWidget);
  });

  testWidgets('SignUpPage widget test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: SignUpPage(),
        ),
      ),
    );

    // Verify if the necessary widgets are present in the widget tree.
    expect(find.byType(TextField), findsNWidgets(5));
    expect(find.byType(ElevatedButton), findsOneWidget);
  });
}
