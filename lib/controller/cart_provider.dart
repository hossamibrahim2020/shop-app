import 'package:flutter/cupertino.dart';
import 'package:fluttershopbloc/model/product_model.dart';

class CartProvider extends ChangeNotifier {
  List<ProductModel> _cartArray = [];
  List<ProductModel> get cartArray => _cartArray;

  void addToCart(ProductModel product) {
    _cartArray.add(product);
    notifyListeners();
  }

  void removeFromCart(ProductModel product) {
    _cartArray.remove(product);
    notifyListeners();
  }
}
