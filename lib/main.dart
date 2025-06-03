import 'package:flutter/material.dart';
import 'package:ecommerce_app/injection_container.dart';
import 'package:ecommerce_app/features/products/presentation/pages/product_list_page.dart';

void main() {
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Commerce',
      home: const ProductListPage(),
    );
  }
}