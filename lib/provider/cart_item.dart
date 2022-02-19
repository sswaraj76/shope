import 'package:flutter/foundation.dart';

class CartItem {
  final String? id;
  final String? title;
  final double? price;
  final int? quantity;

  CartItem(
      {required this.id,
      required this.title,
      required this.price,
      required this.quantity});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _item = {};
  Map<String, CartItem> get item {
    return {..._item};
  }

  int get itemCount {
    return _item.length;
  }

  double get totalItems {
    double total = 0;
    _item.forEach((key, value) {
      total += value.price! * value.quantity!.toInt();
    });
    return total;
  }

  void addItem(String productId, String title, double price) {
    if (_item.containsKey(productId)) {
      _item.update(
          productId,
          (value) => CartItem(
              id: DateTime.now().toString(),
              title: value.title,
              price: value.price,
              quantity: value.quantity! + 1));
    } else {
      _item.putIfAbsent(
          productId,
          () =>
              CartItem(id: productId, title: title, price: price, quantity: 1));
    }
    notifyListeners();
  }

  void removeItems(String productId) {
    _item.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String proID) {
    if (!_item.containsKey(proID)) {
      return;
    }
    if (_item[proID]!.quantity! > 1) {
      _item.update(
        proID,
        (value) => CartItem(
            id: value.id,
            title: value.title,
            price: value.price,
            quantity: value.quantity! - 1),
      );
    } else {
      _item.remove(proID);
    }
    notifyListeners();
  }

  void clear() {
    _item = {};
    notifyListeners();
  }
}
