import 'package:flutter/foundation.dart';

import '../provider/cart_item.dart';

class OrderItem {
  final String id;
  final double totalPrice;
  final List<CartItem> order;
  final DateTime date;

  OrderItem(
      {required this.id,
      required this.order,
      required this.totalPrice,
      required this.date});
}

class Orders with ChangeNotifier {
  final List<OrderItem> _items = [];

  List<OrderItem> get items {
    return [..._items];
  }

  void addOrders(List<CartItem> orders, double total) {
    _items.insert(
      0,
      OrderItem(
        id: DateTime.now().toString(),
        order: orders,
        totalPrice: total,
        date: DateTime.now(),
      ),
    );
  }
}
