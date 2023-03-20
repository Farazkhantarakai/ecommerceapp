import 'package:ecommerce_app/providers/auth.dart';
import 'package:ecommerce_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import './circlepainter.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.blue,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
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
              onTap: () {},
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
            ListTile(
              onTap: () {},
              leading: const Icon(
                Icons.shop_sharp,
                color: whiteColor,
              ),
              title: const Text(
                'Delivery',
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
                Icons.settings,
                color: whiteColor,
              ),
              title: const Text(
                'Settings',
                style: TextStyle(color: whiteColor, fontSize: 17),
              ),
            ),
            Container(
              width: double.infinity,
              height: 180,
              decoration: const BoxDecoration(),
              child: Column(
                children: [
                  CustomPaint(
                    painter: CirclePainter(radius1: 14, radius2: 8),
                  ),
                  Container(
                    color: Colors.blueGrey[300],
                    decoration: const BoxDecoration(shape: BoxShape.circle),
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
