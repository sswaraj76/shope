import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  final String? id;
  final String? title;
  final String? description;
  final String? imageUrl;
  final double? price;
  bool isfavorite;

  Product(
      {required this.id,
      required this.title,
      required this.description,
      required this.imageUrl,
      required this.price,
      this.isfavorite = false});

  void toggleFavorite() {
    isfavorite = !isfavorite;
    notifyListeners();
  }
}
