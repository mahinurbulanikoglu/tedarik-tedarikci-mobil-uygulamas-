import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobil_final_odev/SourceCodes/TedariklerimPage.dart';

void main() {
  testWidgets('TedariklerimPage widget test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: TedariklerimPage(cartItems: ['kalem x1', 'makas x2']),
      ),
    );

    // Verify if the necessary widgets are present in the widget tree.
    expect(find.text('Tedariklerim'), findsOneWidget);
    expect(find.text('Sepetteki Ögeler'), findsOneWidget);
    expect(find.text('kalem'), findsOneWidget);
    expect(find.text('makas'), findsOneWidget);
    expect(find.byType(GestureDetector), findsNWidgets(2));

    // Perform a tap on the first item
    await tester.tap(find.text('kalem'));
    await tester.pumpAndSettle(); // Wait for the page transition to complete

    // Verify if the SecondPageDetail is pushed onto the navigation stack
    expect(find.text('Ürün Detayları'), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
    expect(find.text('kalem'), findsOneWidget);
  });

  // Additional test for SecondPageDetail
  testWidgets('SecondPageDetail widget test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: SecondPageDetail(itemName: 'makas', itemImage: 'images/makas.jpg'),
      ),
    );

    // Verify if the necessary widgets are present in the widget tree.
    expect(find.text('Ürün Detayları'), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
    expect(find.text('makas'), findsOneWidget);
  });
}
