import 'dart:math';
import 'package:ecommerce_app/models/order.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderItemScreen extends StatefulWidget {
  const OrderItemScreen({super.key, required this.item});

  final OrderItem item;

  @override
  State<OrderItemScreen> createState() => _OrderItemScreenState();
}

class _OrderItemScreenState extends State<OrderItemScreen> {
  bool extracted = false;

  @override
  Widget build(BuildContext context) {
    final mdq = MediaQuery.of(context).size;
    return Scaffold(
        body: ListView(
      children: [
        ListTile(
          leading: Text(widget.item.amounts.toString()),
          subtitle:
              Text('${DateFormat('yMMMd').parse(DateTime.now().toString())}'),
          trailing: IconButton(
              onPressed: () {
                setState(() {
                  extracted = !extracted;
                });
              },
              icon: Icon(extracted ? Icons.expand_less : Icons.more_vert)),
        ),
        if (extracted)
          Container(
              width: double.infinity,
              height: min(mdq.height * widget.item.products!.length * 20, 100),
              decoration: const BoxDecoration(),
              child: ListView(children: const [
// widget.item.products!
//                     .map<Widget>((e,value) => const Card(
//                           child: ListTile(
//                             title: Text(''),
//                           ),
//                         ))
//                     .toList(),
              ]))
      ],
    ));
  }
}
