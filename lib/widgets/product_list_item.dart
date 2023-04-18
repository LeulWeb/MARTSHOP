import 'package:flutter/material.dart';
import 'package:martshop/providers/product_provider.dart';
import 'package:provider/provider.dart';

import '../screens/edit_products_screend.dart';

class ProductListTile extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String id;

  const ProductListTile(
      {super.key,
      required this.title,
      required this.imageUrl,
      required this.id});

  @override
  Widget build(BuildContext context) {
    final _product = Provider.of<Products>(context);

    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      title: Text(title),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(EditProductsScreen.routeName, arguments: id);
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                _product.removeProduct(id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
