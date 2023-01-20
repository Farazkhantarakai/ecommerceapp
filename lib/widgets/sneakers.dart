import 'package:flutter/material.dart';

class Sneakers extends StatelessWidget {
  const Sneakers({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(3),
        constraints: const BoxConstraints.expand(width: 105, height: 40),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset(
            'assets/icons/sneaker.png',
            width: 35,
          ),
          const SizedBox(
            width: 4,
          ),
          const Text(
            'Sneakers',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ]));
  }
}
