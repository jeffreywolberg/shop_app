import 'package:flutter/material.dart';
import 'package:shop_app/providers/cart.dart';

class ExpandedCartItem extends StatelessWidget {
  final CartItem cartItem;

  ExpandedCartItem(this.cartItem);

  @override
  Widget build(BuildContext context) {
    // print(cartItem.id);
    // print(cartItem.price);
    // print(cartItem.quantity);
    // print(cartItem.title);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          cartItem.title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '${cartItem.quantity} x \$${cartItem.price}',
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey,
          ),
        )
      ],
    );
  }
}
