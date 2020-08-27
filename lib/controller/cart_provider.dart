import 'package:flutter/cupertino.dart';

class CartProvider extends ChangeNotifier {
  List<CartProduct> _cartArray = [];
  List get cartArray => _cartArray;

  void addToCart(CartProduct product) {
    _cartArray.add(product);
    notifyListeners();
  }

  void removeFromCart(CartProduct product) {
    _cartArray.add(product);
    notifyListeners();
  }
}

class CartProduct {
  String title, pieces, price, image;
  CartProduct(this.title, this.image, this.price, this.pieces);
}
