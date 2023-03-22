import 'package:ecommerce_app/providers/orders.dart';
import 'package:ecommerce_app/screens/OrderItemScreen.dart';
import 'package:ecommerce_app/utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mdq = MediaQuery.of(context).size;
    final order = Provider.of<Orders>(context).orderItem;
    final appBar = AppBar(
      backgroundColor: const Color.fromARGB(255, 235, 234, 234),
      centerTitle: true,
      elevation: 1,
      title: const Text(
        'Order History',
        style: TextStyle(color: Colors.black),
      ),
    );
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 235, 234, 234),
        appBar: appBar,
        body: FutureBuilder(
            future: Provider.of<Orders>(context, listen: false)
                .fetchAndSetProduct(),
            builder: (
              context,
              snapshot,
            ) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                );
              } else {
                if (kDebugMode) {
                  print('${snapshot.error}');
                }
                if (snapshot.error != null) {
                  return const Center(
                    child: Text(
                      'there is something went wrong',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  );
                } else {
                  return Consumer<Orders>(
                    builder: (context, norder, child) {
                      return ListView.builder(
                          itemCount: norder.orderItem.length,
                          itemBuilder: (context, index) {
                            return OrderItemScreen(
                                item: norder.orderItem[index]);
                          });
                    },
                  );
                }
              }
            }));
  }
}
