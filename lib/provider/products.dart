import 'package:flutter/cupertino.dart';

import 'product.dart';

class Products with ChangeNotifier {
  final List<Product> _item = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  List<Product> get item {
    return [..._item];
  }

  List<Product> get favItem {
    return _item.where((element) => element.isfavorite == true).toList();
  }

  Product findById(String id) {
    return _item.firstWhere((element) => element.id == id);
  }

  void addItem(Product prod) {
    var _newProduct = Product(
        id: DateTime.now().toString(),
        title: prod.title,
        description: prod.description,
        imageUrl: prod.imageUrl,
        price: prod.price);

    _item.add(_newProduct);
    notifyListeners();
  }

  void updateItem(String id, Product prod) {
    var proIndex = _item.indexWhere((element) => element.id == id);

    _item[proIndex] = prod;
    notifyListeners();
  }

  void deleteItem(String id) {
    _item.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
