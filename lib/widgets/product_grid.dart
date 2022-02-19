import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/products.dart';
import '../widgets/product_item.dart';

class ProductGrid extends StatelessWidget {
  final bool showFav;
  const ProductGrid({Key? key, required this.showFav}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productID = Provider.of<Products>(context);

    final productData = showFav ? productID.favItem : productID.item;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
      ),
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        value: productData[index],
        child: const ProductItem(),
      ),
      itemCount: productData.length,
    );
  }
}
