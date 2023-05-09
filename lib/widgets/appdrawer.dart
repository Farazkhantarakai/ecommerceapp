import 'package:ecommerce_app/providers/auth.dart';
import 'package:ecommerce_app/screens/OrderItemScreen.dart';
import 'package:ecommerce_app/screens/order.dart';
import 'package:ecommerce_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.blue,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                ListTile(
                  onTap: () {},
                  leading: const Icon(
                    Icons.person,
                    color: whiteColor,
                  ),
                  title: const Text(
                    'Profile',
                    style: TextStyle(color: whiteColor, fontSize: 17),
                  ),
                ),
                Container(
                  height: 20,
                  margin: const EdgeInsets.only(left: 60, right: 10),
                  child: const Divider(color: whiteColor, height: 1),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pushNamed(OrderScreen.routName);
                  },
                  leading: const Icon(
                    Icons.shopping_cart,
                    color: whiteColor,
                  ),
                  title: const Text(
                    'My Orders',
                    style: TextStyle(color: whiteColor, fontSize: 17),
                  ),
                ),
                Container(
                  height: 20,
                  margin: const EdgeInsets.only(left: 60, right: 10),
                  child: const Divider(color: whiteColor, height: 1),
                ),
                ListTile(
                  onTap: () {},
                  leading: const Icon(
                    Icons.favorite,
                    color: whiteColor,
                  ),
                  title: const Text(
                    'Favourites',
                    style: TextStyle(color: whiteColor, fontSize: 17),
                  ),
                ),
                Container(
                  height: 20,
                  margin: const EdgeInsets.only(left: 60, right: 10),
                  child: const Divider(color: whiteColor, height: 1),
                ),
              ],
            ),
            Container(
              width: double.infinity,
              height: 180,
              decoration: const BoxDecoration(),
              child: Column(
                children: [
                  // CustomPaint(
                  //   painter: CirclePainter(radius1: 14, radius2: 8),
                  // ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blueGrey[300],
                    ),
                  )
                ],
              ),
            ),
            ListTile(
              onTap: () {
                Provider.of<Auth>(context, listen: false).logOut();
              },
              leading: const Icon(
                Icons.exit_to_app,
                color: whiteColor,
              ),
              title: const Text(
                'Sign_out',
                style: TextStyle(color: whiteColor, fontSize: 17),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
