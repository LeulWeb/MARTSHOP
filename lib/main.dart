import 'package:flutter/material.dart';
import 'package:martshop/providers/cart_provider.dart';
import 'package:martshop/providers/order_provider.dart';
import 'package:martshop/providers/product_provider.dart';
import 'package:martshop/screens/cart_screen.dart';
import 'package:martshop/screens/orders_screen.dart';
import 'package:martshop/screens/product_detail_screen.dart';
import 'package:martshop/screens/product_overview_screen.dart';
import 'package:provider/provider.dart';

import 'screens/edit_products_screend.dart';
import 'screens/my_sell_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Products(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => CartItems(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Orders(),
        )
      ],
      child: MaterialApp(
        title: 'Mart Shop',
        theme: ThemeData(
          colorSchemeSeed: Colors.blue,
          // fontFamily: 'Anton',
        ),
        home: ProductOverview(),
        routes: {
          ProductDetail.routeName: (ctx) => const ProductDetail(),
          CartScreen.routeName: (ctx) => const CartScreen(),
          OrderScreen.routeName: (ctx) => const OrderScreen(),
          MySellScreen.routeName: (ctx) => const MySellScreen(),
          EditProductsScreen.routeName: (ctx) =>  EditProductsScreen(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
