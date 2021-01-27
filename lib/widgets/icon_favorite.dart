import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';
import '../providers/product.dart';

class IconFavorite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);
    final product = Provider.of<Product>(context);
    final authData = Provider.of<Auth>(context, listen: false);
    return IconButton(
      icon: Icon(product.isFavorite ? Icons.favorite : Icons.favorite_border),
      color: Theme.of(context).accentColor,
      onPressed: () async {
        try {
          await product.toggleFavoriteStatus(authData.token, authData.userId);
          print('rebuilt Icon');
        } catch (error) {}
      },
    );
  }
}
