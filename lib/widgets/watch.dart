import 'package:flutter/material.dart';

class Watch extends StatelessWidget {
  const Watch({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(5),
        constraints: const BoxConstraints.expand(width: 100, height: 40),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset(
            'assets/icons/watch.png',
            width: 30,
          ),
          const SizedBox(
            width: 1,
          ),
          const Text(
            'Watch',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ]));
  }
}
