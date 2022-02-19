import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart';

import '../widgets/product_grid.dart';
import '../widgets/drawer_items.dart';
import '../provider/cart_item.dart';
import '../screen/cart_screen.dart';

enum FavoriteToggle { all, favorite }

class ProductOverviewScreen extends StatefulWidget {
  const ProductOverviewScreen({Key? key}) : super(key: key);

  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _showFav = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shope"),
        actions: [
          PopupMenuButton(
              onSelected: (FavoriteToggle onSelected) {
                setState(() {
                  if (onSelected == FavoriteToggle.favorite) {
                    _showFav = true;
                  } else {
                    _showFav = false;
                  }
                });
                if (onSelected == FavoriteToggle.favorite) {
                  _showFav = true;
                }
              },
              icon: const Icon(Icons.more_vert),
              itemBuilder: (_) => const [
                    PopupMenuItem(
                      child: Text("Favorites"),
                      value: FavoriteToggle.favorite,
                    ),
                    PopupMenuItem(
                      child: Text("All"),
                      value: FavoriteToggle.all,
                    ),
                  ]),
          Consumer<Cart>(
              builder: (context, value, chWig) => InkWell(
                    onTap: () =>
                        Navigator.of(context).pushNamed(CartScreen.routName),
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Badge(
                        child: chWig,
                        badgeContent: Text(
                          value.itemCount.toString(),
                          style: const TextStyle(color: Colors.white),
                        ),
                        badgeColor: Theme.of(context).colorScheme.secondary,
                        showBadge: value.itemCount > 0 ? true : false,
                        animationType: BadgeAnimationType.scale,
                        animationDuration: const Duration(microseconds: 250),
                      ),
                    ),
                  ),
              child: const Icon(Icons.shopping_cart)),
        ],
      ),
      drawer: const DrawerItem(),
      body: ProductGrid(showFav: _showFav),
    );
  }
}
