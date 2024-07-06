import 'dart:convert';
import 'dart:io';

import 'package:intl/intl.dart';

const imageURL = 'https://api.timbu.cloud/images';

class Product {
  final String id;
  final String name;
  final String description;
  final Map<String, dynamic> price;
  final List<String> photos;
  final bool isAvailable;
  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.photos,
    required this.isAvailable,
  });

  // sanitizedPrice is used to get the price, format it in the 
  // form e.g "2,345.67", in 2 decimal place, and return as String
  String get sanitizedPrice {
    var str = '';
    price.forEach((key, value) {
      str += getCurrencySymbol(key);
      str += NumberFormat('#,##0.00')
          .format(((value as List).first as double))
          .toString();
    });

    return str;
  }

  // - getCurrencySymbol is used to convert the currency code e.g "NGN"
  // to it's respective symbol "₦"
  String getCurrencySymbol(String name) {
    var format =
        NumberFormat.simpleCurrency(locale: Platform.localeName, name: name);
    return format.currencySymbol;
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      price: ((map['current_price'] ?? []) as List).firstOrNull ?? {},
      photos: List<String>.from(
        (map['photos'] as List).map((e) => '$imageURL/${e['url']}'),
      ),
      isAvailable: map['is_available'],
    );
  }

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Product(id: $id, name: $name, description: $description, isAvailable:$isAvailable, price: $price, photos: $photos)';
  }

  @override
  bool operator ==(covariant Product other) {
    if (identical(this, other)) return true;

    return other.id == id;
  }

  @override
  int get hashCode {
    return id.hashCode;
  }
}
