import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:flutter/foundation.dart';
import '../providers/cart.dart';
import 'package:http/http.dart' as http;

const url = 'https://shop-app-57fae-default-rtdb.firebaseio.com/orders.json';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    final response = await http.get(url);
    final List<OrderItem> loadedOrders = [];
    final ordersData = json.decode(response.body) as Map<String, dynamic>;
    if (ordersData == null) {
      return;
    }

    var pData;
    List<CartItem> products;

    ordersData.forEach((orderId, orderData) {
      products = (orderData['products'] as List<dynamic>).map((pData) {
        return CartItem(
          id: pData['id'],
          price: pData['price'],
          quantity: pData['quantity'],
          title: pData['title'],
        );
      }).toList();

      print(['ProductsFirstMethod', products]);

      var extractedProducts = (orderData['products'] as List<dynamic>);
      products = [];
      for (int i = 0; i < extractedProducts.length; i++) {
        pData = extractedProducts[i];
        products.add(CartItem(
          id: pData['id'],
          price: pData['price'],
          quantity: pData['quantity'],
          title: pData['title'],
        ));
      }

      print(['ProductsSecondMethod', products]);

      // print('Produts');
      // final prods = orderData['products'] as List<dynamic>;
      // final d = prods.map((prod) {
      //   prod['id'];
      // }).toList();
      // print(d);

      loadedOrders.add(OrderItem(
          amount: orderData['amount'],
          id: orderId,
          dateTime: DateTime.parse(orderData['dateTime']),
          products: products));
    });
    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final timestamp = DateTime.now();
    try {
      final response = await http.post(url,
          body: json.encode({
            'amount': total,
            'dateTime': timestamp.toIso8601String(),
            'products': cartProducts
                .map((cp) => {
                      'id': cp.id,
                      'title': cp.title,
                      'quantity': cp.quantity,
                      'price': cp.price
                    })
                .toList(),
          }));

      _orders.insert(
        0,
        OrderItem(
          id: json.decode(response.body)['name'],
          amount: total,
          dateTime: timestamp,
          products: cartProducts,
        ),
      );
    } catch (error) {
      print(error);
      throw error;
    }
    notifyListeners();
  }
}
