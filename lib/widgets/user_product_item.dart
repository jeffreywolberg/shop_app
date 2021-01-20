import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/screens/edit_product_screen.dart';
import 'package:shop_app/screens/user_products_screen.dart';

class UserProductItem extends StatelessWidget {
  final String title;
  final double price;
  final String imageUrl;
  final String id;
  final String description;

  UserProductItem(
      {this.title, this.price, this.imageUrl, this.id, this.description});

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);
    final productsData = Provider.of<Products>(context).items;
    return ListTile(
      title: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title),
            Text(
              price.toStringAsFixed(2),
            ),
          ],
        ),
      ),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(EditProductScreen.routeName, arguments: id);
              },
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                try {
                  await Provider.of<Products>(context, listen: false)
                      .removeProduct(id);
                } catch (error) {
                  scaffold.showSnackBar(SnackBar(
                    content: Text(
                      'Deleting Failed!',
                      textAlign: TextAlign.center,
                    ),
                  ));
                }
              },
              color: Colors.red,
            )
          ],
        ),
      ),
    );
  }
}
