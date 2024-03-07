import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobil_final_odev/SourceCodes/ProfilPage.dart';

void main() {
  testWidgets('ProfilePage widget test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: ProfilePage(),
      ),
    );

    // Verify if the necessary widgets are present in the widget tree.
    expect(find.text('Profil'), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);
    expect(find.byType(TextFormField), findsOneWidget);

    // Perform a tap on the 'Yeni Ürün Ekle' button
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle(); // Wait for the page transition to complete

    // Verify if the NewItemPage is pushed onto the navigation stack
    expect(find.text('Yeni Ürün Ekle'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2)); // Two TextFormFields on the NewItemPage
  });
}
