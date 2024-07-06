import 'package:flutter/material.dart';
import 'package:timbu/src/views/products_detail/photos_viewer.dart';

import '../../models/product.dart';
import '../../utils/app_colors.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            surfaceTintColor: kBGColor,
            foregroundColor: kBGColor,
            expandedHeight: MediaQuery.of(context).size.height * 0.5,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              background: PhotosViewer(photos: product.photos),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(20.0),
                  width: double.infinity,
                  color: kBGColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10.0),
                      Text(
                        product.name,
                        style: const TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.w600,
                          color: kTextColor,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 5.0),
                        decoration: BoxDecoration(
                          color:
                              product.isAvailable ? kActiveColor : Colors.red,
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        child: Text(
                          product.isAvailable ? 'Available' : 'Unavailable',
                          style: const TextStyle(
                            color: kBGColor,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Text(
                        product.description,
                        style: const TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                          color: kTextColor,
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      Text(
                        product.sanitizedPrice,
                        style: const TextStyle(
                          fontSize: 27.0,
                          fontWeight: FontWeight.w400,
                          color: kSecondaryTextColor,
                        ),
                      ),
                      const SizedBox(height: 30.0),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
