import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../models/custom_api_error.dart';
import '../models/product.dart';

const baseURL = 'https://api.timbu.cloud';

final class ProductsRepo {
  const ProductsRepo();
  // - configures and fetches the products using the organizationId, appID and apiKey,
  // - checks the status code to handle error if it exists,
  // - deserialize the data into Products to get the necessary data
  Future<List<Product>> fetchProducts() async {
    await dotenv.load();
    final organizationId = dotenv.get('ORGANIZATION_ID');
    final appID = dotenv.get('APPID');
    final apiKey = dotenv.get('APIKEY');
    final url =
        '$baseURL/products?organization_id=$organizationId&Appid=$appID&Apikey=$apiKey&page=1&size=10';

    try {
      final res = await http.get(Uri.parse(url));
      final body = json.decode(res.body);
      if (res.statusCode != 200) {
        final error = body['detail'] is String
            ? body['detail']
            : 'An error occured\nwhile fetching products!';
        throw CustomApiError(message: error);
      }

      final items = (body['items'] as List).cast<Map<String, dynamic>>();
      return items.map(Product.fromMap).toList();
    } catch (_) {
      rethrow;
    }
  }
}
