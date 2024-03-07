import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobil_final_odev/SourceCodes/SecondPage.dart';

void main() {
  testWidgets('SecondPage widget test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: SecondPage(),
      ),
    );

    // Verify if the necessary widgets are present in the widget tree.
    expect(find.text('Ürünler'), findsOneWidget);
    expect(find.byIcon(Icons.shopping_cart), findsOneWidget);
    expect(find.byIcon(Icons.person), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
    expect(find.byType(ListTile), findsWidgets);

    // Perform a tap on the first item in the list
    await tester.tap(find.byType(ListTile).first);
    await tester.pumpAndSettle(); // Wait for the page transition to complete

    // Verify if the DetailsPage is pushed onto the navigation stack
    expect(find.text('Ürün Detayları'), findsOneWidget);
    expect(find.text('Sepete Ekle'), findsOneWidget);
  });

  testWidgets('DetailsPage widget test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: DetailsPage(productName: 'kalem.jpg', productImage: 'images/kalem.jpg'),
      ),
    );

    // Verify if the necessary widgets are present in the widget tree.
    expect(find.text('Ürün Detayları'), findsOneWidget);
    expect(find.text('Sepete Ekle'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.byType(Hero), findsOneWidget);

    // Perform a tap on the 'Sepete Ekle' button
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle(); // Wait for the page transition to complete

    // Verify if the TedariklerimPage is pushed onto the navigation stack
    expect(find.text('Sepetim'), findsOneWidget);
  });
}
