import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product.dart';

class IconFavorite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    return IconButton(
      icon: Icon(product.isFavorite ? Icons.favorite : Icons.favorite_border),
      color: Theme.of(context).accentColor,
      onPressed: () {
        product.toggleFavoriteStatus();
        print('rebuilt');
      },
    );
  }
}
