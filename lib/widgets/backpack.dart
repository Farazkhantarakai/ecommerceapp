import 'package:flutter/material.dart';

class BackPack extends StatelessWidget {
  const BackPack({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 2),
        constraints: const BoxConstraints.expand(width: 100, height: 40),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset(
            'assets/icons/bag.png',
            width: 30,
          ),
          const SizedBox(
            width: 1,
          ),
          const Text(
            'Backpack',
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ]));
  }
}
