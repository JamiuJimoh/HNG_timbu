import 'package:flutter/material.dart';

import '../../services/products_repo.dart';
import '../../utils/app_colors.dart';
import '../error_text.dart';
import 'products_tile.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  static const repo = ProductsRepo();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: FutureBuilder(
          future: repo.fetchProducts(),
          builder: (_, snapshot) {
            // Using connectionState of the snapshot to determing and handle the
            // 3 important states (loading, error, data)
            return switch (snapshot.connectionState) {
              ConnectionState.waiting =>
                const Center(child: CircularProgressIndicator.adaptive()),
              // ConnectionState.done =>
              ConnectionState.done when snapshot.hasError => Expanded(
                  child: Center(child: ErrorText(error: snapshot.error!)),
                ),
              ConnectionState.done when snapshot.hasData => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Featured products',
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.w600,
                        color: kTextColor,
                      ),
                    ),
                    const SizedBox(height: 23.0),
                    Expanded(
                      child: GridView.builder(
                        itemCount: snapshot.data!.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.65,
                          mainAxisSpacing: 28.0,
                          crossAxisSpacing: 20.0,
                        ),
                        itemBuilder: (_, i) {
                          final product = snapshot.data![i];
                          return ProductTile(
                            product: product,
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                '/product-details',
                                arguments: product,
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              _ => const SizedBox(),
            };
          },
        ),
      ),
    );
  }
}
