import 'package:flutter/material.dart';

import '../models/cart_items.dart';
import '../models/order.dart';

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get items => [..._orders];

  void addOrder(List<CartItem> items, double amount) {
    _orders.insert(
      0,
      OrderItem(
        date: DateTime.now(),
        items: items,
        amount: amount,
        id: DateTime.now().toString(),
      ),
    );

    notifyListeners();
    
  }
}
