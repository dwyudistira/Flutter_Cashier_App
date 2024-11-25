import 'package:flutter/material.dart';

class CheckoutPage extends StatelessWidget {
  final List<Map<String, dynamic>> selectedItems;

  const CheckoutPage({super.key, required this.selectedItems});

  @override
  Widget build(BuildContext context) {
    // Menghitung total harga
    int totalPrice = selectedItems.fold(
      0,
      (sum, item) => sum + ((item['quantity'] as int) * (item['price'] as int)),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Daftar Produk yang Dibeli",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            // Menampilkan daftar produk yang dibeli
            selectedItems.isNotEmpty
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: selectedItems.length,
                    itemBuilder: (context, index) {
                      final item = selectedItems[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: ListTile(
                          leading: Image.asset(item['image'] ?? ''),
                          title: Text(item['name'] ?? ''),
                          subtitle: Text('${item['quantity']} x Rp ${item['price']}'),
                          trailing: Text(
                            'Rp ${(item['quantity'] as int) * (item['price'] as int)}',
                          ),
                        ),
                      );
                    },
                  )
                : const Center(
                    child: Text("Tidak ada produk yang dipilih."),
                  ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 10),
            // Menampilkan total pembayaran
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Total Pembayaran",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "Rp $totalPrice",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Tombol pembayaran
            ElevatedButton(
              onPressed: () {
                // Proses checkout
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Pembayaran berhasil!')),
                );
                // Arahkan kembali ke halaman sebelumnya
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'Bayar',
                style: TextStyle(fontSize: 16),
              ),
            )
          ],
        ),
      ),
    );
  }
}
