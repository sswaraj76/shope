import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/products.dart';

class ProductDetailsScreen extends StatelessWidget {
  static const routName = '/product_details_screen';
  const ProductDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final productDetail =
        Provider.of<Products>(context, listen: false).findById(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(productDetail.title!),
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            width: double.infinity,
            child: Image(
              fit: BoxFit.contain,
              image: NetworkImage(productDetail.imageUrl!),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "₹${productDetail.price!.toString()}",
            style: const TextStyle(
              color: Colors.blueGrey,
              fontSize: 25,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              productDetail.description!,
              softWrap: true,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          )
        ],
      ),
    );
  }
}
