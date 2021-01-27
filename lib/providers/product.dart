import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/models/http_exception.dart';

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

  Future<void> toggleFavoriteStatus(String token, String userId) async {
    print(id);
    print(this.title);
    final String url =
        'https://shop-app-57fae-default-rtdb.firebaseio.com/userFavoriteProducts/$userId/$id.json?auth=$token';
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    print(isFavorite);
    notifyListeners();

    // final response = await http.patch(url,
    //     body: json.encode({
    //       'title': title,
    //       'imageUrl': imageUrl,
    //       'description': description,
    //       'price': price,
    //       'isFavorite': isFavorite,
    //     }));
    final response = await http.put(
      url,
      body: json.encode(
        isFavorite,
      ),
    );
    if (response.statusCode >= 400) {
      print(response.statusCode);
      isFavorite = oldStatus;
      notifyListeners();
      throw HttpException('Couldn\'t be deleted');
    }
  }
}
