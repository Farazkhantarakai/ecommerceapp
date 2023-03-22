import 'dart:math';
import 'package:ecommerce_app/models/cartmodel.dart';
import 'package:ecommerce_app/models/order.dart';
import 'package:ecommerce_app/providers/auth.dart';
import 'package:ecommerce_app/providers/cartitem.dart';
import 'package:ecommerce_app/providers/orders.dart';
import 'package:ecommerce_app/screens/check_out_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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
        DateTime.fromMillisecondsSinceEpoch(widget.item.dateTime!.toInt());
    // DateFormat.
    final dt = DateFormat('yMMMd').format(dateTime);
    final orderList = Provider.of<Orders>(context, listen: true);

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
      background: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Center(
                child: IconButton(
                    onPressed: () {
                      setState(() {
                        orderList.deletOrder(widget.item.id.toString());
                      });
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.blue,
                    )))
          ],
        ),
      ),
      onDismissed: (direction) {},
      key: ValueKey(widget.item.id),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10),
        elevation: 2,
        child: Column(
          children: [
            ListTile(
              contentPadding: const EdgeInsets.all(10),
              leading: Text(
                widget.item.amounts.toString(),
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
              title:
                  // Text(  '${DateFormat('dd-MM-yyyy hh:mm').parse(dateTime.toString())}'),
                  Text(
                dt,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
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
              Column(
                children: [
                  Container(
                      width: double.infinity,
                      height: max(widget.item.products!.length.toDouble(), 150),
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
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                '${productList[index].price}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              trailing: Text(
                                '${productList[index].quantity}x',
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            );
                          })),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'You will recieve your product with in 3 days',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              fixedSize: const Size(100, 40),
                              backgroundColor:
                                  const Color.fromARGB(255, 248, 66, 34)),
                          onPressed: () {},
                          child: const Text(
                            'Cancel',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                      ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              fixedSize: const Size(100, 40)),
                          child: const Text(
                            'Track ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  )
                ],
              )
          ],
        ),
      ),
    );
  }
}
