import 'package:flutter/material.dart';
import 'package:martshop/providers/order_provider.dart';
import 'package:martshop/widgets/order_card.dart';
import 'package:provider/provider.dart';

import '../widgets/app_drawer.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});
  static String routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Order"),
        centerTitle: true,
      ),
      drawer: const AppDrawer(),
      body: ListView.builder(
        itemCount: orderData.items.length,
        itemBuilder: (ctx, index) => OrderCard(
          order: orderData.items[index],
        ),
      ),
    );
  }
}
