import 'dart:math';
import 'package:ecommerce_app/models/cartmodel.dart';
import 'package:ecommerce_app/models/order.dart';
import 'package:ecommerce_app/providers/cartitem.dart';
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
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(widget.item.dateTime! * 1000);

    final productList = widget.item.products!.entries.map((entry) {
      final value = entry.value;
      return CartModel(
          value['id'],
          value['title'],
          value['image'],
          value['price'],
          value['size'],
          value['color'],
          value['perOff'],
          value['quantity']);
    }).toList();
    return Dismissible(
      onDismissed: (direction) {},
      key: UniqueKey(),
      child: Card(
        elevation: 2,
        child: Column(
          children: [
            ListTile(
              leading: Text(
                widget.item.amounts.toString(),
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                  '${DateFormat('dd-MM-yyyy hh:mm').parse(dateTime.toString())}'),
              trailing: IconButton(
                  onPressed: () {
                    setState(() {
                      extracted = !extracted;
                    });
                  },
                  icon:
                      Icon(extracted ? Icons.expand_less : Icons.expand_more)),
            ),
            if (extracted)
              Container(
                  width: double.infinity,
                  height:
                      min(mdq.height * widget.item.products!.length * 20, 150),
                  decoration: const BoxDecoration(),
                  child: ListView.builder(
                      itemCount: productList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CircleAvatar(
                              maxRadius: 50,
                              backgroundImage: NetworkImage(
                                '${productList[index].image}',
                              )),
                          title: Text(
                            '${productList[index].title}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            '${productList[index].price}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          trailing: Text(
                            '${productList[index].quantity}x',
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        );
                      }))
          ],
        ),
      ),
    );
  }
}
