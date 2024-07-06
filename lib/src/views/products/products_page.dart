import 'package:flutter/material.dart';

import '../../controllers/products_controller.dart';
import '../../models/product.dart';
import '../../utils/app_colors.dart';
import '../error_text.dart';
import 'products_tile.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final _products = <Product>[];
  var _isLoading = false;
  Object? _error;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // fetch the list of products only once, immediately we get
      // to the page. Not using FutureBuilder because it's calling the
      // api multiple times which is not efficient.
      await _fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: _error != null
            ? Expanded(
                child: Center(child: ErrorText(error: _error!)),
              )
            : Column(
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
                    child: _isLoading
                        ? const Center(
                            child: CircularProgressIndicator.adaptive(),
                          )
                        : GridView.builder(
                            itemCount: _products.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.65,
                              mainAxisSpacing: 28.0,
                              crossAxisSpacing: 20.0,
                            ),
                            itemBuilder: (_, i) {
                              final product = _products[i];
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
                  const SizedBox(height: 20.0),
                ],
              ),
      ),
    );
  }

  // this calls the controller which configures the request and fetches the 
  // list of products. It also sets the 3 states (loading, error, data)
  Future<void> _fetchProducts() async {
    setState(() {
      _isLoading = true;
    });
    final controller = ProductsController();
    try {
      final res = await controller.fetchProducts();
      setState(() {
        _products.addAll(res);
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _error = e;
      });
    }
  }
}
