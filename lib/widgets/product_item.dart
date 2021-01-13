import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';
import 'package:shop_app/widgets/icon_favorite.dart';
import '../providers/product.dart';
import '../screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;

  // ProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    print('rebuilt Product Item');
    // final productsData = Provider.of<Products>(context);

    // see 'Consumer' Widget below. We can set listen to false, because
    // we aren't interested in listening to the whole product when it changes
    // just the isFavorite bool. By having a Consumer Widget wrapped around only
    // the Widgets that are affected by isFavorite, it will listen and rerender
    // the Widgets only at that point
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: product.id,
            );
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        header: GridTileBar(
          backgroundColor: Colors.black26,
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
        ),
        footer: GridTileBar(
          leading: IconFavorite(),
          // leading: Consumer<Product>(
          //   builder: (ctx, product, child) => IconButton(
          //     icon: Icon(
          //         product.isFavorite ? Icons.favorite : Icons.favorite_border),
          //     color: Theme.of(context).accentColor,
          //     onPressed: () {
          //       product.toggleFavoriteStatus();
          //       print('rebuilt');
          //     },
          //   ),
          // ),
          title: SizedBox(
            width: 10,
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            color: Theme.of(context).accentColor,
            onPressed: () {
              cart.addItem(product.id, product.price, product.title);
            },
          ),
        ),
      ),
    );
  }
}
