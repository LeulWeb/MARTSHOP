import 'package:flutter/material.dart';
import 'package:martshop/providers/product_provider.dart';
import 'package:martshop/screens/edit_products_screend.dart';
import 'package:provider/provider.dart';

import '../widgets/app_drawer.dart';
import '../widgets/product_list_item.dart';

class MySellScreen extends StatefulWidget {
  const MySellScreen({super.key});
  static const String routeName = '/sell';

  @override
  State<MySellScreen> createState() => _MySellScreenState();
}

class _MySellScreenState extends State<MySellScreen> {
  @override
  Widget build(BuildContext context) {
    
    final data = Provider.of<Products>(context);
    final product = data.items;

    return Scaffold(
        appBar: AppBar(
          title: const Text("My Products"),
          actions: [
            //This is where we add items
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(EditProductsScreen.routeName);
              },
            )
          ],
        ),
        drawer: const AppDrawer(),
        body: ListView.builder(
            itemCount: product.length,
            itemBuilder: (_, i) => Column(
                  children: [
                    ProductListTile(
                      id: product[i].id,
                      title: product[i].name,
                      imageUrl: product[i].imageUrl,
                    ),
                    const Divider(),
                  ],
                )));
  }
}
