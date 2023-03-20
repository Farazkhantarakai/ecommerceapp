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
      backgroundColor: Colors.white,
      centerTitle: true,
      elevation: 0,
      title: const Text(
        'Order History',
        style: TextStyle(color: Colors.black),
      ),
    );
    return Scaffold(
        backgroundColor: whiteColor,
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
                    color: Colors.blue,
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
