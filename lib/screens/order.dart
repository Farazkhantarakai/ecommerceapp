import 'package:ecommerce_app/providers/orders.dart';
import 'package:ecommerce_app/screens/OrderItemScreen.dart';
import 'package:ecommerce_app/screens/check_out_screen.dart';
import 'package:ecommerce_app/utils/constants.dart';
import 'package:ecommerce_app/widgets/noorder.dart';
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
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (kDebugMode) {
                  print('${snapshot.error}');
                }

                if (snapshot.error != null) {
                  return const Text('Something went wrong ');
                } else {
                  return Consumer<Orders>(
                    builder: (context, order, child) {
                      return ListView.builder(
                          itemCount: order.orderItem.length,
                          itemBuilder: (context, index) {
                            return Container(
                              color: Colors.green,
                            );
                            // OrderItemScreen(
                            //     item: order.orderItem[index]);
                          });
                    },
                  );
                }
              }
            }));
  }
}
