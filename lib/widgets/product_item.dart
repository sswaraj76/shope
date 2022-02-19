import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screen/product_details_screen.dart';
import '../provider/product.dart';
import '../provider/cart_item.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prod = Provider.of<Product>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: InkWell(
          onTap: () {
            Navigator.of(context)
                .pushNamed(ProductDetailsScreen.routName, arguments: prod.id);
          },
          child: Image(
            image: NetworkImage(prod.imageUrl!),
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Product>(
            builder: (context, value, child) => IconButton(
              icon: Icon(
                Icons.favorite,
                color: prod.isfavorite ? Colors.red : Colors.white,
              ),
              onPressed: () {
                prod.toggleFavorite();
              },
            ),
          ),
          title: Text(
            prod.title!,
            maxLines: 2,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontFamily: Theme.of(context).textTheme.bodyText1!.fontFamily),
          ),
          trailing: Consumer<Cart>(
            builder: (context, value, child) => IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                value.addItem(prod.id!, prod.title!, prod.price!);
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text("Item Added to Cart"),
                    action: SnackBarAction(
                      label: "UNDO",
                      onPressed: () {
                        value.removeSingleItem(prod.id!);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
