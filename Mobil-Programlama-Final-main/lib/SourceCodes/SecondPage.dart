import 'package:flutter/material.dart';
import 'package:mobil_final_odev/SourceCodes/TedariklerimPage.dart';
import 'package:mobil_final_odev/SourceCodes/ProfilPage.dart';



class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  List<ItemModel> itemList = [
    ItemModel(name: 'kalem.jpg', imagePath: 'images/kalem.jpg'),
    ItemModel(name: 'makas.jpg', imagePath: 'images/makas.jpg'),
    ItemModel(name: 'zimba.jpeg', imagePath: 'images/zimba.jpeg'),
  ];

  List<String> cartItems = [];
  String addedToCartMessage = '';

  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ürünler'),
        backgroundColor: Color(0xFFF176B87),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TedariklerimPage(cartItems: cartItems),
                ),
              );
            },
            icon: Icon(Icons.shopping_cart),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
            icon: Icon(Icons.person),
          ),
        ],
      ),
      body: Container(
        color: Color(0xFFF9EFDB),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Ürün Ara...',
                  suffixIcon: Icon(Icons.search),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: itemList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(itemList[index].name),
                        IconButton(
                          icon: Icon(Icons.shopping_cart),
                          onPressed: () {
                            _addToCart(itemList[index].name);
                          },
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsPage(
                            productName: itemList[index].name,
                            productImage: itemList[index].imagePath,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            addedToCartMessage.isNotEmpty
                ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                addedToCartMessage,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            )
                : SizedBox(),
          ],
        ),
      ),
    );
  }

  void _addToCart(String item) {
    setState(() {
      if (cartItems.any((cartItem) => cartItem.contains(item))) {
        for (int i = 0; i < cartItems.length; i++) {
          if (cartItems[i].contains(item)) {
            if (cartItems[i].contains('x')) {
              int count = int.parse(cartItems[i].split('x').last) + 1;
              cartItems[i] = '$item x$count';
            } else {
              cartItems[i] = '$item x2';
            }
            break;
          }
        }
      } else {
        cartItems.add('$item x1');
      }

      addedToCartMessage = '$item sepete eklendi';

      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          addedToCartMessage = '';
        });
      });
    });
    ItemModel selectedProduct = itemList.firstWhere((element) => element.name == item);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailsPage(
          productName: selectedProduct.name,
          productImage: selectedProduct.imagePath,
        ),
      ),
    );

  }
}

class DetailsPage extends StatelessWidget {
  final String productName;
  final String productImage; // Ürün resminin dosya adı

  DetailsPage({required this.productName, required this.productImage});

  @override
  Widget build(BuildContext context) {
    String fullImagePath = 'images/$productName'; // Resim dosyasının tam yolu

    return Scaffold(
      appBar: AppBar(
        title: Text('Ürün Detayları'),
        backgroundColor: Color(0xFFF176B87),
      ),
      body: Container(
        color: Color(0xFFF9EFDB), // Arka plan rengi
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: 'product_image_$productName',
                child: Image.asset(
                  fullImagePath, // AssetImage kullanılarak resim yükleniyor
                  height: 200.0,
                ),
              ),
              SizedBox(height: 16.0),
              Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(
                  productName,
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  _addToCart(context, productName, productImage);
                },
                child: Text('Sepete Ekle'),
              ),
              SizedBox(height: 16.0),
              // Ürün detaylarını gösteren kutucuk
              Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ürün Detayları:',
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Buraya ürünün detayları yazılacak.',
                      style: TextStyle(fontSize: 14.0),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addToCart(BuildContext context, String itemName, String itemImage) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TedariklerimPage(cartItems: ['$itemName x1'], itemImages: []),
      ),
    );
  }
}

class ItemModel {
  final String name;
  final String imagePath; // Ürün resminin dosya adı

  ItemModel({required this.name, required this.imagePath});
}
