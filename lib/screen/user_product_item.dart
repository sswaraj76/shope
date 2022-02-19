import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/drawer_items.dart';
import '../widgets/user_added_item.dart';
import '../provider/products.dart';
import '../screen/edit_product_screen.dart';

class UserProductItem extends StatelessWidget {
  static const routName = "/productManagmentpage";
  const UserProductItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Products"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(EditProductScreen.routName, arguments: "");
              },
              icon: const Icon(Icons.add))
        ],
      ),
      drawer: const DrawerItem(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemBuilder: (context, index) => UserAddedItem(
              id: pro.item[index].id,
              image: pro.item[index].imageUrl!,
              title: pro.item[index].title!),
          itemCount: pro.item.length,
        ),
      ),
    );
  }
}
