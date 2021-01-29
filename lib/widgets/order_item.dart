import 'dart:math';

import 'package:flutter/material.dart';
import './expanded_cart_item.dart';
import '../providers/orders.dart' as ord;
import 'package:intl/intl.dart';

class OrderItem extends StatefulWidget {
  final ord.OrderItem order;

  OrderItem(this.order);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: _expanded ? widget.order.products.length * 20.0 + 110 : 95,
      duration: Duration(milliseconds: 200),
      curve: Curves.easeIn,
      child: Card(
        // return Card(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            ListTile(
              title: Text('\$${widget.order.amount}'),
              subtitle: Text(
                DateFormat('MM/dd/yyyy hh:mm').format(widget.order.dateTime),
              ),
              trailing: IconButton(
                icon: Icon(
                  _expanded ? Icons.expand_less : Icons.expand_more,
                ),
                onPressed: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
              ),
            ),
            if (_expanded)
              // AnimatedContainer(
              //   height:
              //       _expanded ? widget.order.products.length * 20.0 + 20 : 0,
              //   duration: Duration(milliseconds: 200),
              //   curve: Curves.easeIn,
              Container(
                height: widget.order.products.length * 20.0 + 15,
                padding: EdgeInsets.symmetric(horizontal: 20),
                color: Colors.white,
                child: ListView.builder(
                    itemCount: widget.order.products.length,
                    itemBuilder: (ctx, i) =>
                        ExpandedCartItem(widget.order.products[i])),
              ),
          ],
        ),
      ),
    );
  }
}
