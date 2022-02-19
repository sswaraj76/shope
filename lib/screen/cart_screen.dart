import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/cart_item.dart';
import '../provider/orders.dart';
import '../widgets/cart_item_display.dart';

class CartScreen extends StatelessWidget {
  static const routName = "/cartscreen";
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartItem = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart Item"),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total",
                      style: TextStyle(fontSize: 20),
                    ),
                    const Spacer(),
                    Chip(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      label: Text(
                        "₹ ${cartItem.totalItems.toStringAsFixed(2)}",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {
                        Provider.of<Orders>(context, listen: false).addOrders(
                          cartItem.item.values.toList(),
                          cartItem.totalItems,
                        );
                        cartItem.clear();
                      },
                      shape: const StadiumBorder(),
                      child: const Text("ORDER NOW"),
                    )
                  ]),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) => CartItemDisplay(
                  id: cartItem.item.values.toList()[index].id!,
                  productId: cartItem.item.keys.toList()[index],
                  title: cartItem.item.values.toList()[index].title!,
                  price: cartItem.item.values.toList()[index].price!,
                  quantity: cartItem.item.values.toList()[index].quantity!),
              itemCount: cartItem.item.length,
            ),
          )
        ],
      ),
    );
  }
}
