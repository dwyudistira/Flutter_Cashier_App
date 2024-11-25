import 'package:flutter/material.dart';
import 'Cashier_page.dart'; // Import the file where CashierPage is defined

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cashier App',
      home: const CashierPage(), // This should now work
    );
  }
}
