import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/orders.dart' show Orders;
import '../widgets/ordersItem.dart';
import '../widgets/drawer_items.dart';

class OrdersScreen extends StatelessWidget {
  static const routName = "/ordersScreen";
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Your Orders",
        ),
      ),
      drawer: const DrawerItem(),
      body: ListView.builder(
        itemBuilder: (context, index) =>
            OrdersItem(order: orderData.items[index]),
        itemCount: orderData.items.length,
      ),
    );
  }
}
