import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../provider/orders.dart' as ord;

class OrdersItem extends StatefulWidget {
  final ord.OrderItem order;
  const OrdersItem({Key? key, required this.order}) : super(key: key);

  @override
  State<OrdersItem> createState() => _OrdersItemState();
}

class _OrdersItemState extends State<OrdersItem> {
  bool _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Column(
        children: [
          ListTile(
            title: Text("₹ ${widget.order.totalPrice}"),
            subtitle: Text(
              DateFormat("dd-mm-yyyy \n HH:MM").format(widget.order.date),
            ),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          if (_expanded)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              height: min(widget.order.order.length * 20.0 + 10, 120),
              child: ListView(
                children: widget.order.order
                    .map(
                      (e) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            e.title!,
                            style: const TextStyle(fontSize: 16),
                          ),
                          Text(
                            "₹ ${e.quantity}*${e.price}",
                            style: const TextStyle(fontSize: 16),
                          )
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
        ],
      ),
    );
  }
}
