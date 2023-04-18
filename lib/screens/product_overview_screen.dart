import 'package:flutter/material.dart';
import 'package:martshop/providers/cart_provider.dart';
import 'package:provider/provider.dart';
import '../widgets/app_drawer.dart';
import '../widgets/product_grid.dart';
import '../widgets/badge.dart';
import 'cart_screen.dart';

enum FavOption { favorite, all }

class ProductOverview extends StatefulWidget {
  const ProductOverview({super.key});

  @override
  State<ProductOverview> createState() => _ProductOverviewState();
}

class _ProductOverviewState extends State<ProductOverview> {
  bool _showFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MartShop"),
        actions: [
          PopupMenuButton(
            onSelected: (FavOption value) {
              setState(() {
                if (value == FavOption.all) {
                  _showFavorite = false;
                } else {
                  _showFavorite = true;
                }
              });
            },
            icon: const Icon(Icons.more_vert),
            itemBuilder: (_) {
              return const [
                PopupMenuItem(
                  value: FavOption.favorite,
                  child: Text('Only Favourite'),
                ),
                PopupMenuItem(
                  value: FavOption.all,
                  child: Text('Show all'),
                ),
              ];
            },
          ),
          Consumer<CartItems>(
            builder: (_, cart, ch) => MyBadge(
              value: cart.itemsNumber.toString(),
              child: IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.pushNamed(context, CartScreen.routeName);
                },
              ),
            ),
          )
        ],
      ),
      drawer: const AppDrawer(),
      body: ProductsGrid(
        showFav: _showFavorite,
      ),
    );
  }
}


//If it is defined outside of the builder function it will not be rebuilt {child in consumer}