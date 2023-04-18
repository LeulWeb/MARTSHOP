import 'package:flutter/material.dart';

import '../screens/my_sell_screen.dart';
import '../screens/orders_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text('Welcome'),
            //this will not show the back button which is displayed by default in flutter
            automaticallyImplyLeading: false,
          ),
          ListTile(
            leading: const Icon(
              Icons.shop,
            ),
            title: const Text("Shop"),
            onTap: () {
              Navigator.pushNamed(context, '/');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.payment,
            ),
            title: const Text("Orders"),
            onTap: () {
              Navigator.pushNamed(
                context,
                OrderScreen.routeName,
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.storefront,
            ),
            title: const Text("My Products"),
            onTap: () {
              Navigator.pushNamed(
                context,
                MySellScreen.routeName,
              );
            },
          ),
        ],
      ),
    );
  }
}
