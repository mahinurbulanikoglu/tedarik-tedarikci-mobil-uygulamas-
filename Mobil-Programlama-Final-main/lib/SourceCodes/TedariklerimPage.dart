import 'package:flutter/material.dart';
import 'package:mobil_final_odev/SourceCodes/SecondPage.dart';

class TedariklerimPage extends StatelessWidget {
  final List<String> cartItems;
  final List<String> itemImages; // Eklenen ürünlerin resim dosya adlarını içeren liste

  // Constructor'ı güncellendi
  TedariklerimPage({required this.cartItems, this.itemImages = const []});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tedariklerim'),
        backgroundColor: Color(0xFFF176B87),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                'Sepetteki Ögeler',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            SizedBox(height: 8.0),
            buildCartItemsList(context),
          ],
        ),
      ),
      backgroundColor: Color(0xFFF9EFDB),
    );
  }

  Widget buildCartItemsList(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          String itemName = cartItems[index].split(' x').first.trim();
          String itemImage = itemImages.isNotEmpty
              ? itemImages.firstWhere((image) => image.startsWith(itemName), orElse: () => '')
              : '';

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SecondPageDetail(itemName: itemName, itemImage: itemImage),
                ),
              );
            },
            child: buildCartItemBox(itemName, itemImage),
          );
        },
      ),
    );
  }

  Widget buildCartItemBox(String itemName, String itemImage) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
              child: Image.asset(
                'images/makas.jpg', // Resim dosya yolu, images klasöründen alındığı varsayıldı
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              itemName,
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class SecondPageDetail extends StatelessWidget {
  final String itemName;
  final String itemImage;

  SecondPageDetail({required this.itemName, required this.itemImage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ürün Detayları'),
        backgroundColor: Color(0xFFF176B87),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/makas.jpg',
              height: 200.0,
            ),
            SizedBox(height: 16.0),
            Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                itemName,
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}