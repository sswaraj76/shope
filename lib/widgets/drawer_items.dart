import 'package:flutter/material.dart';

import '../screen/orders_screen.dart';
import '../screen/user_product_item.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            elevation: 0,
            title: const Text("Hello"),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.shop),
            title: const Text("Procudts"),
            onTap: () => Navigator.of(context).pushReplacementNamed("/"),
          ),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text("Procudts"),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(OrdersScreen.routName),
          ),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text("User Products"),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(UserProductItem.routName),
          ),
        ],
      ),
    );
  }
}
