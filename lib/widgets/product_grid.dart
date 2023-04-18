import 'package:flutter/material.dart';
import 'package:martshop/providers/product.dart';
import 'package:martshop/widgets/product_item.dart';
import 'package:provider/provider.dart';

import '../providers/product_provider.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFav;

  const ProductsGrid({super.key, required this.showFav});

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    final List<Product> products =
        showFav ? productData.favItems : productData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemBuilder: (ctx, index) {
        //ChangeNotifierProvider.value shows we are only intersted in the value not on context
        return ChangeNotifierProvider.value(
        value:products[index],
          child: const ProductItem(),
        );
      },
    );
  }
}
