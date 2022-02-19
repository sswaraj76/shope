import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screen/edit_product_screen.dart';
import '../provider/products.dart';

class UserAddedItem extends StatelessWidget {
  final String? id;
  final String? title;
  final String? image;
  const UserAddedItem(
      {Key? key, required this.id, required this.title, required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
      ),
      child: Card(
        child: ListTile(
          leading: SizedBox(
            height: 50,
            width: 50,
            child: Image(
              fit: BoxFit.contain,
              image: NetworkImage(image!),
            ),
          ),
          title: Text(title!),
          trailing: SizedBox(
            width: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(EditProductScreen.routName, arguments: id);
                    },
                  ),
                ),
                Expanded(
                  child: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      Provider.of<Products>(context, listen: false)
                          .deleteItem(id!);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
