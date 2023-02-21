import 'package:ecommerce_app/main.dart';
import 'package:ecommerce_app/utils/constants.dart';
import 'package:flutter/material.dart';

class NoOrder extends StatelessWidget {
  const NoOrder({super.key});

  @override
  Widget build(BuildContext context) {
    final mdq = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          'assets/icons/buissness.png',
          height: mdq.height * 0.3,
        ),
        const Text(
          'No history yet',
          style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
        ),
        const Center(
            child: Text(
          'Click on the orange button down',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 17),
        )),
        const Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Center(
              child: Text(
            'below to create an order',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 17),
          )),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, MyHomeApp.routName);
          },
          child: Container(
            margin: const EdgeInsets.only(top: 10),
            width: mdq.width * 0.7,
            height: mdq.height * 0.06,
            decoration: const BoxDecoration(
                color: orangeButton,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: const Center(
              child: Text(
                'Start Ordering',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
        )
      ],
    );
  }
}
