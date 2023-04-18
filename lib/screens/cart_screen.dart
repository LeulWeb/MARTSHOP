import 'package:flutter/material.dart';
import 'package:martshop/providers/cart_provider.dart';
import 'package:martshop/providers/order_provider.dart';
import 'package:martshop/widgets/cart.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  static const routeName = '/cart';
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartItems>(context);
    final order = Provider.of<Orders>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Cart"),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Chip(
                    label: Text(
                      '\$${cart.totalAmount.toStringAsFixed(2)}',
                      style: const TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      order.addOrder(
                        cart.item.values.toList(),
                        cart.totalAmount,
                      );
                      cart.clearCart();
                    },
                    child: const Text("Order"),
                  )
                ],
              ),
            ),
          ),

          //We can not create list view inside of column the list view needs to be wrapped by Expanded widget

          Expanded(
            child: ListView.builder(
              itemCount: cart.itemsNumber,
              itemBuilder: (context, index) => CartListTile(
                productId: cart.item.keys.toList()[index],
                title: cart.item.values.toList()[index].title,
                price: cart.item.values.toList()[index].price,
                id: cart.item.values.toList()[index].id,
                quantity: cart.item.values.toList()[index].quantity,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
