import 'package:flutter/material.dart';
import 'package:martshop/providers/cart_provider.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //once we got the data from the list of product we are not going to listen for changes any more 'Yo give me the data and I do not need it anymore'
    final product = Provider.of<Product>(context, listen: false);

    //Here we are just using the provider packaget just to add an item that is just to dispatch an action nothing more nothing less hence there is no need to notify and rebuild this UI whenever the changes occur to our list of cart items

    final cart = Provider.of<CartItems>(context, listen: false);
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          ProductDetail.routeName,
          arguments: product.id,
        );
      },
      child: GridTile(
        footer: GridTileBar(
          title: Text(
            product.name,
            textAlign: TextAlign.center,
          ),

          //we can alse use consumer to wrap sub tree to listen to changes after getting one data and setting the item to listen : false hence it will not update
          leading: Consumer<Product>(
            builder: (ctx, product, child) => IconButton(
              onPressed: () {
                product.togglesisFav();
              },
              icon: Icon(
                product.isFavourite ? Icons.favorite : Icons.favorite_border,
              ),
              color: Theme.of(context).primaryColor,
            ),
          ),
          trailing: IconButton(
            onPressed: () {
              cart.addItem(product.id, product.name, product.price);

              //Displaying snackbar
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.greenAccent,
                  content: const Text("Item added to cart"),
                  action: SnackBarAction(
                    label: "UNDO",
                    onPressed: () {
                      cart.removeSingleItem(product.id);
                    },
                  ),
                ),
              );
            },
            icon: const Icon(
              Icons.shopping_cart,
            ),
          ),
          backgroundColor: Colors.black54,
        ),
        child: Image.network(
          product.imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
