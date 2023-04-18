import 'package:flutter/material.dart';
import 'package:martshop/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class CartListTile extends StatelessWidget {
  const CartListTile({
    super.key,
    required this.title,
    required this.price,
    required this.id,
    required this.quantity,
    required this.productId,
  });

  final String title;
  final double price;
  final String id;
  final String productId;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    final cartI = Provider.of<CartItems>(context);

    return Dismissible(
      confirmDismiss: (direction) {
        //display alert dialog box
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text("Are you sure ?"),
            content:
                const Text("Do you want to delete the item from your cart"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text("Okay"),
              ),
            ],
          ),
        );
      },
      key: ValueKey(id),
      background: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        color: Theme.of(context).colorScheme.error,
        alignment: Alignment.centerRight,
        child: const Icon(
          Icons.delete,
          size: 40,
          color: Colors.white,
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        cartI.removeItem(productId);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: FittedBox(
                child: Text(price.toString()),
              ),
            ),
            title: Text(title),
            subtitle: Text('\$${price * quantity}'),
            trailing: Text('$quantity X'),
          ),
        ),
      ),
    );
  }
}
