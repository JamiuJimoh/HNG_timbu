import 'package:flutter/material.dart';
import 'src/models/product.dart';
import 'src/utils/app_theme.dart';
import 'src/views/products/products_page.dart';
import 'src/views/products_detail/product_detail_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const ProductsPage(),
      routes: {
        '/products': (_) => const ProductsPage(),
        '/product-details': (context) {
        // Must provide a "Product" when routing to this page using the named-route
          final product = ModalRoute.of(context)!.settings.arguments as Product;
          return ProductDetailPage(product: product);
        },
      },
    );
  }
}
