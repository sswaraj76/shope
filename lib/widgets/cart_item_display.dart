import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/cart_item.dart';

class CartItemDisplay extends StatelessWidget {
  final String id;
  final String productId;
  final String title;
  final double price;
  final int quantity;
  const CartItemDisplay(
      {Key? key,
      required this.id,
      required this.productId,
      required this.title,
      required this.price,
      required this.quantity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  content: const Text("Do you want to delete the item?"),
                  title: const Text("Are you sure?"),
                  actions: [
                    MaterialButton(
                      child: const Text("No"),
                      onPressed: (() {
                        Navigator.of(context).pop(false);
                      }),
                    ),
                    MaterialButton(
                      child: const Text("Yes"),
                      onPressed: (() {
                        Navigator.of(context).pop(true);
                      }),
                    )
                  ],
                ));
      },
      background: Container(
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 15),
        alignment: Alignment.centerRight,
        color: Theme.of(context).errorColor,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItems(productId);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 15),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: FittedBox(
                child: Text(
                  price.toStringAsFixed(2),
                ),
              ),
            ),
          ),
          title: Text(title),
          subtitle: Text("Quantity: $quantity "),
          trailing: Text("₹${price * quantity}"),
        ),
      ),
    );
  }
}
