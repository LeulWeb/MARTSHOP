import 'package:flutter/foundation.dart';
import 'package:martshop/models/cart_items.dart';

class CartItems with ChangeNotifier {
  //Create a map instead of a list of product
  final Map<String, CartItem> _items = {};

  //getter Method
  Map<String, CartItem> get item => {..._items};

  int get itemsNumber => _items.length;

  //Method to get the total amount
  double get totalAmount {
    double total = 0.0;

    _items.forEach((key, value) {
      total += value.price * value.quantity;
    });
    return total;
  }

  //Method to add to cart
  void addItem(String productId, String title, double price) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (currentItem) => CartItem(
          id: currentItem.id,
          price: currentItem.price,
          quantity: currentItem.quantity + 1,
          title: currentItem.title,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          price: price,
          quantity: 1,
          title: title,
        ),
      );
    }

    notifyListeners();
  }

  void removeItem(productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  // removing a single item when the user press the undo button
  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }

    if (_items[productId]!.quantity > 1) {
      _items.update(
          productId,
          (existing) => CartItem(
                id: existing.id,
                price: existing.price,
                quantity: existing.quantity - 1,
                title: existing.title,
              ));
    } else {
      _items.remove(productId);
    }

    notifyListeners();
  }
}
