import 'package:flutter/material.dart';
import 'package:martshop/providers/product_provider.dart';
import 'package:provider/provider.dart';

class ProductDetail extends StatelessWidget {
  //route Name
  static const routeName = '/productDetail';

  const ProductDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final String id = ModalRoute.of(context)!.settings.arguments as String;

    final loadedItem =
        Provider.of<Products>(context, listen: false).findById(id);

    return Scaffold(
      appBar: AppBar(
        title: Text(loadedItem.name),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 300,
            child: Image.network(
              loadedItem.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            loadedItem.name,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Text(
              loadedItem.description,
              textAlign: TextAlign.justify,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Price: ",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: Colors.grey),
                ),
                Text("\$${loadedItem.price}",
                    style: Theme.of(context).textTheme.headlineSmall),
              ],
            ),
          )
        ],
      ),
    );
  }
}
