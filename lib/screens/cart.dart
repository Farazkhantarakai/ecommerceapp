import 'package:ecommerce_app/models/cartmodel.dart';
import 'package:ecommerce_app/models/order.dart';
import 'package:ecommerce_app/providers/cartitem.dart';
import 'package:ecommerce_app/widgets/single-cartitem.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/check_out_screen.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  static const routName = 'cart';

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  bool? isLoading = false;

  @override
  Widget build(BuildContext context) {
    var mdq = MediaQuery.of(context).size;
    var cartitem = Provider.of<CartItem>(context, listen: true);

    double total = cartitem.getTotal;
    double tax = cartitem.getCartItem.length * 5;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 233, 233, 233),
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          elevation: 0,
          leading: cartitem.isLongPress == true
              ? Container(
                  decoration: const BoxDecoration(),
                  child: IconButton(
                    onPressed: () {
                      cartitem.changeLongPress();
                      cartitem.removeItemFromDeletion();
                    },
                    icon: const Icon(
                      Icons.dangerous,
                      color: Colors.grey,
                    ),
                  ),
                )
              : Container(),
          actions: [
            IconButton(
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });

                  await cartitem.doDeleteItems();
                  cartitem.changeLongPress();
                  cartitem.fetchCartItem().then((v) {
                    setState(() {
                      isLoading = false;
                    });
                  });
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.grey,
                  size: 25,
                ))
          ],
          centerTitle: true,
          title: const Text(
            'My Cart',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          )),
      body: isLoading!
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.grey,
              ),
            )
          : Column(
              children: [
                Container(
                  width: double.infinity,
                  height: mdq.height * 0.57,
                  decoration: const BoxDecoration(),
                  child: ListView.builder(
                      itemCount: cartitem.getCartItem.length,
                      itemBuilder: (context, index) {
                        return ChangeNotifierProvider<CartModel>.value(
                          //in this way we have to take single item from a map
                          value: cartitem.getCartItem.values.toList()[index],
                          builder: ((context, child) {
                            return SingleCartItem(
                                //i am passing the of that particular element as well
                                itemKey:
                                    cartitem.getCartItem.keys.toList()[index]);
                          }),
                        );
                      }),
                ),
// Check out add button and total
                Container(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  width: double.infinity,
                  height: 52,
                  decoration: const BoxDecoration(),
                  child: Row(
                    children: [
                      Text.rich(TextSpan(
                          text: 'Subtotal:  ',
                          style: const TextStyle(
                              fontSize: 17,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(
                                text: '\$${total + tax}',
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold))
                          ])),
                      const Spacer(),
                      Text.rich(TextSpan(
                          text: 'Taxes:  ',
                          style: const TextStyle(
                              fontSize: 17,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(
                                text: '\$$tax',
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold))
                          ]))
                    ],
                  ),
                ),

//total plus checkout button
                Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  width: double.infinity,
                  height: mdq.height * 0.099,
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 248, 248, 248),
                      borderRadius: BorderRadius.only()),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$ ${cartitem.getCartItem.length * 5 + total} ',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 42, 74, 253)),
                          onPressed: cartitem.getCartItem.isEmpty
                              ? null
                              : () {
                                  if (kDebugMode) {
                                    print(cartitem.getCartItem.values);
                                  }
                                  Navigator.pushNamed(
                                      context, ItemOrderScreen.routName,
                                      arguments: {
                                        'total': total,
                                        'cartItems': cartitem.getCartItem
                                      });
                                },
                          icon: const Icon(Icons.price_check),
                          label: const Text(
                            'Add Order',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ))
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
