import 'package:flutter/material.dart';
import 'package:mobil_final_odev/SourceCodes/SecondPage.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<ItemModel> addedItems = []; // Eklenen ürünleri tutacak liste

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
        backgroundColor: Color(0xFFF176B87),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ürünlerim:',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
            SizedBox(height: 20.0),
            _buildAddedItemsList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Yeni ürün ekleme sayfasına yönlendirme
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewItemPage(onItemAdded: _onItemAdded),
            ),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0xFFF176B87),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      backgroundColor: Color(0xFFF9EFDB),
    );
  }

  Widget _buildAddedItemsList() {
    return addedItems.isNotEmpty
        ? Expanded(
      child: ListView.builder(
        itemCount: addedItems.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Her ürüne tıklandığında detay sayfasına git
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ItemDetailPage(item: addedItems[index]),
                ),
              );
            },
            child: Card(
              elevation: 5.0,
              margin: EdgeInsets.symmetric(vertical: 8.0),
              color: Color(0xFFE0E0E0),
              child: ListTile(
                title: Text(addedItems[index].name),
              ),
            ),
          );
        },
      ),
    )
        : Text('Henüz ürün eklenmedi.');
  }

  void _onItemAdded(ItemModel item) {
    setState(() {
      addedItems.add(item);
    });
  }
}

class ItemDetailPage extends StatelessWidget {
  final ItemModel item;

  ItemDetailPage({required this.item});

  @override
  Widget build(BuildContext context) {

    String itemImage = 'images/zimba.jpeg';

    return Scaffold(
      appBar: AppBar(
        title: Text('Ürün Detayları'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                item.name,
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 16.0),
            // Ürün resmi
            Image.asset(
              itemImage,
              height: 200.0,
            ),
            SizedBox(height: 16.0),
            // Ürün detayları
            Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                'Ürün Adı : Zimba\n'
                    'Sektör : Kırtasiye\n'
                    'Fiyat : 50 TL',
                style: TextStyle(fontSize: 16.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NewItemPage extends StatefulWidget {
  final Function(ItemModel) onItemAdded;

  NewItemPage({required this.onItemAdded});

  @override
  _NewItemPageState createState() => _NewItemPageState();
}

class _NewItemPageState extends State<NewItemPage> {
  late TextEditingController _newItemNameController;

  @override
  void initState() {
    super.initState();
    _newItemNameController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yeni Ürün Ekle'),
        backgroundColor: Color(0xFFF176B87), // AppBar rengi
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _newItemNameController,
              decoration: InputDecoration(
                labelText: 'Ürün Adı',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                String newItemName = _newItemNameController.text;
                if (newItemName.isNotEmpty) {
                  // Yeni ürünü eklemek için gerekli işlemleri yapabilirsiniz.
                  ItemModel newItem = ItemModel(name: newItemName, imagePath: 'default_image.jpg');
                  widget.onItemAdded(newItem);

                  // Yeni ürün eklendikten sonra, bu sayfadan çıkış yapabilirsiniz.
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Lütfen ürün adını girin')),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF9DBC98), // Buton rengi
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
              child: Text('Ekle'),
            ),
          ],
        ),
      ),
      backgroundColor: Color(0xFFF9EFDB), // Arka plan rengi
    );
  }
}

class NewItemPage2 extends StatefulWidget {
  final Function(String) onItemAdded;

  NewItemPage2({required this.onItemAdded});

  @override
  _NewItemPage2State createState() => _NewItemPage2State();
}

class _NewItemPage2State extends State<NewItemPage2> {
  late TextEditingController _newItemNameController;
  late TextEditingController _newItemImageController;

  @override
  void initState() {
    super.initState();
    _newItemNameController = TextEditingController();
    _newItemImageController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yeni Ürün Ekle'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _newItemNameController,
              decoration: InputDecoration(
                labelText: 'Ürün Adı',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _newItemImageController,
              decoration: InputDecoration(
                labelText: 'Ürün Resmi (URL)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                String newItemName = _newItemNameController.text;
                String newItemImage = _newItemImageController.text;

                if (newItemName.isNotEmpty && newItemImage.isNotEmpty) {
                  // Yeni ürünü eklemek için gerekli işlemleri yapabilirsiniz.
                  widget.onItemAdded(newItemName);

                  // Yeni ürün eklendikten sonra, bu sayfadan çıkış yapabilirsiniz.
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Lütfen tüm alanları doldurun')),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
              child: Text('Ekle'),
            ),
          ],
        ),
      ),
    );
  }
}
