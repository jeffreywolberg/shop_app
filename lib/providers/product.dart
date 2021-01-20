import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/models/http_exceptions.dart';

const url = 'https://shop-app-57fae-default-rtdb.firebaseio.com/products.json';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  Future<void> toggleFavoriteStatus(Product product) async {
    final String urlSpecific = url.split('.json')[0] + '/${product.id}.json';
    final oldStatus = product.isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();

    final response = await http.patch(urlSpecific,
        body: json.encode({
          'title': product.title,
          'imageUrl': product.imageUrl,
          'description': product.description,
          'price': product.price,
          'isFavorite': isFavorite,
        }));
    if (response.statusCode >= 400) {
      isFavorite = oldStatus;
      notifyListeners();
      throw HttpException('Couldn\'t be deleted');
    }
    ;
  }
}
