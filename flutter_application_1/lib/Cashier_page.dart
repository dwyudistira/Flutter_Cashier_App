import 'checkout_page.dart';
import 'package:flutter/material.dart';

class CashierPage extends StatefulWidget {
  const CashierPage({super.key});

  @override
  State<CashierPage> createState() => _CashierPageState();
}

class _CashierPageState extends State<CashierPage> {
  final TextEditingController searchController = TextEditingController();

  List<Map<String, dynamic>> products = [
    {
      "image": "assets/images/Adeel4.jpg",
      "name": "Antangin",
      "price": 3000,
      "stock": 10,
      'quantity': 0,
    },
    {
      "image": "assets/images/Adel.jpg",
      "name": "Teh Sariwangi",
      "price": 5000,
      "stock": 10,
      'quantity': 0,
    },
    {
      "image": "assets/images/Adel2.jpg",
      "name": "UltraMilk",
      "price": 9000,
      "stock": 10,
      'quantity': 0,
    },
    {
      "image": "assets/images/Adel3.jpg",
      "name": "Indomies",
      "price": 3500,
      "stock": 10,
      'quantity': 0,
    },
  ];


  List<Map<String, dynamic>> selectedItems = [];

void updateCart(Map<String, dynamic> product, bool isAdding) {
  setState(() {
    if (isAdding) {
      if (product['stock'] > 0) {
        product['quantity']++;
        product['stock']--;
        if (!selectedItems.contains(product)) {
          selectedItems.add(product);
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Stok ${product['name']} habis '),
            backgroundColor: Colors.red, 
          ),
        );
      }
    } else {
      if (product['quantity'] > 0) {
        product['quantity']--;
        product['stock']++;
        if (product['quantity'] == 0) {
          selectedItems.remove(product);
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Tidak bisa memesan ${product['name']} kurang dari 0'),
            backgroundColor: Colors.orange, 
          ),
        );
      }
    }
  });
}


  @override
  Widget build(BuildContext context) {
    int totalItems = selectedItems.fold(0, (sum, item) => sum + (item['quantity'] as int));
    int totalPrice = selectedItems.fold(0, (sum, item) => sum + ((item['quantity'] as int) * (item['price'] as int)));

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Cashier App",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                const Text(
                  "Semoga harimu menyenangkan :)",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: searchController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Cari produk...',
                    hintStyle: TextStyle(color: Colors.grey[500]),
                    prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
          Positioned(
            top: 210,
            left: 20,
            right: 20,
            bottom: 70,
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 15),
              itemCount: products.length,
              itemBuilder: (context, index) {
                var product = products[index];
                return Container(
                  height: 90,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 90,
                        width: 90,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            bottomLeft: Radius.circular(12),
                          ),
                          image: DecorationImage(
                            image: AssetImage(product['image']),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product['name'],
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87,
                                  ),
                                ),
                                Text(
                                  "Stok: ${product['stock']}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "Rp ${product['price']}",
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () => updateCart(product, false),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                                  child: const Icon(Icons.remove, color: Colors.red, size: 18),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                decoration: BoxDecoration(
                                  border: Border.symmetric(
                                    vertical: BorderSide(color: Colors.grey.shade300),
                                  ),
                                ),
                                child: Text(
                                  '${product['quantity']}',
                                  style: const TextStyle(fontSize: 14, color: Colors.black),
                                ),
                              ),
                              GestureDetector(
                                onTap: () => updateCart(product, true),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                                  child: const Icon(Icons.add, color: Colors.green, size: 18),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: SizedBox(
                width: double.infinity, // Full-width checkout button
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CheckoutPage(selectedItems: selectedItems),
                      ),
                    );
                  },
                  label: Text(
                    'Total Items: $totalItems = Rp $totalPrice',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  icon: const Icon(Icons.shopping_cart, color: Colors.white),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
