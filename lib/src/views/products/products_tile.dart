import 'package:flutter/material.dart';

import '../../models/product.dart';
import '../../utils/app_colors.dart';
import '../network_image.dart';

class ProductTile extends StatelessWidget {
  const ProductTile({
    super.key,
    required this.product,
    required this.onTap,
  });
  final Product product;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      // using layout builder to get the available height for each product tile
      // dividing it into 2 parts. The image part takes 70% while the text part
      // takes 30%
      child: LayoutBuilder(
        builder: (_, constraint) {
          final imgSize = constraint.maxHeight * 0.7;
          final descSize = constraint.maxHeight * 0.3;
          return Column(
            children: [
              SizedBox(
                height: imgSize,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(13.0),
                  child: CustomNetworkImage(
                    url: product.photos.first,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(
                height: descSize,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10.0),
                    Text(
                      product.name,
                      maxLines: 2,
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: kTextColor,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      product.sanitizedPrice,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: kSecondaryTextColor,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
