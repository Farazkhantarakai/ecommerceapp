import 'dart:convert';

import 'package:ecommerce_app/main.dart';
import 'package:ecommerce_app/models/CartD.dart';
import 'package:ecommerce_app/models/cartmodel.dart';
import 'package:ecommerce_app/models/httpexception.dart';
import 'package:ecommerce_app/models/order.dart';
import 'package:ecommerce_app/providers/cartitem.dart';
import 'package:ecommerce_app/providers/orders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

enum Order { cashondelivery, paynow }

class ItemOrderScreen extends StatefulWidget {
  const ItemOrderScreen({
    super.key,
  });

  static const routName = './itemOrderScreen';

  @override
  State<ItemOrderScreen> createState() => _ItemOrderScreenState();
}

class _ItemOrderScreenState extends State<ItemOrderScreen> {
//this is of the type order enum
  Order? _order = Order.paynow;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final _form = GlobalKey<FormState>();

  bool _ready = false;

  Map<String, dynamic>? paymentIntentData;

  Future<void> intpayment(
      {required String email,
      required double amount,
      required List<Cartd> item}) async {
    try {
      final response = await http
          .post(Uri.parse("https://api.stripe.com/v1/payment_intents"), body: {
        "receipt_email": email,
        "amount": amount.toInt().toString(),
        "currency": "usd"
      }, headers: {
        'Authorization': 'Bearer '
            'sk_test_51N1SG5HWB5SDvH3syHrIesOj0zNqHDKsYRo1Dr7JKW2NXIrtJ7SQJnWjOVYntDuhdxWutxguDkK2WJH7mweZgU5Z00zo2wdygM',
        'Content-Type': 'application/x-www-form-urlencoded'
      });

      final jsonresponse = jsonDecode(response.body);
      String clientSecret = jsonresponse['client_secret'];

      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: clientSecret,
        merchantDisplayName: 'Faraz khan',
      ));

      await Stripe.instance.presentPaymentSheet();

      Fluttertoast.showToast(
        msg: "You Added payment successfully and the order is on the way now ",
      );
    } catch (e) {
      if (e is StripeException) {
        Fluttertoast.showToast(
          msg: "Stripe error $e",
        );

        debugPrint(e.toString());
      }
      Fluttertoast.showToast(
        msg: "Payment cancelled",
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    Map<String, CartModel> cartItem = data['cartItems'];
    var total = data['total'];
    final mdq = MediaQuery.of(context).size;
    var order = Provider.of<Orders>(context, listen: false);
    final cart = Provider.of<CartItem>(context, listen: false);
    List<Cartd> items = data['item'] as List<Cartd>;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 235, 234, 234),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        backgroundColor: const Color.fromARGB(255, 235, 234, 234),
        title: const Text(
          'Add Order',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 1,
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(),
              child: ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Total Items:   ${cartItem.length}',
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Total Price:  $total',
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(
                    height: mdq.height * 0.02,
                  ),
                  const Text(
                    'Select your payment method: ',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  RadioListTile<Order>(
                      value: Order.paynow,
                      title: const Text('Pay now'),
                      contentPadding: const EdgeInsets.only(left: 30),
                      groupValue: _order,
                      onChanged: (Order? value) {
                        setState(() {
                          _order = value!;
                        });
                      }),
                  RadioListTile<Order>(
                      value: Order.cashondelivery,
                      contentPadding: const EdgeInsets.only(left: 30),
                      title: const Text('Cash On Delivery'),
                      groupValue: _order,
                      onChanged: (Order? value) {
                        setState(() {
                          _order = value!;
                        });
                      }),
                  Form(
                      key: _form,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 10, left: 10, right: 10),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _nameController,
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return 'Name Field  cannot be empty';
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                    hintText: 'Enter your name '),
                              ),
                              TextFormField(
                                controller: _emailController,
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return 'email field cannot be empty';
                                  } else if (!val.endsWith('@gmail.com')) {
                                    return 'email should contain @gmail.com';
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                    hintText: 'Enter your email '),
                              ),
                              TextFormField(
                                controller: _addressController,
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return 'Address  field cannot be empty';
                                  }
                                  return null;
                                },
                                maxLength: 200,
                                maxLines: 5,
                                decoration: const InputDecoration(
                                    hintText: 'Enter your Address'),
                              ),
                            ],
                          ),
                        ),
                      )),
                  Container(
                    width: double.infinity,
                    height: 100,
                    margin: const EdgeInsets.only(left: 10, top: 10),
                    decoration: const BoxDecoration(),
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          return Image.network(
                            items[index].imageUrl,
                            colorBlendMode: BlendMode.darken,
                          );
                        }),
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () async {
                if (_form.currentState!.validate()) {
                  if (_order == Order.paynow) {
                    await intpayment(
                        email: _emailController.text.toString().trim(),
                        amount: total,
                        item: items);

                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                  } else {
                    try {
                      var result = await order.addOrderItem(
                          id: const Uuid().v4().toString(),
                          amounts: total.toString(),
                          dateTime: DateTime.now().millisecondsSinceEpoch,
                          products: cartItem,
                          status: OrderItem.statusToString(Status.completed),
                          name: _nameController.text.toString(),
                          address: _addressController.text.toString(),
                          email: _emailController.text.toString(),
                          paymentMethod: 'Cash On Delivery');
                      if (result == 'Success') {
                        Fluttertoast.showToast(
                            msg: 'Your item is onthe way',
                            backgroundColor: Colors.blue);
                        // ignore: use_build_context_synchronously
                        Navigator.pushNamedAndRemoveUntil(
                            context, MyHomeApp.routName, (route) => false);
                      }
                    } on HttpException catch (err) {
                      Fluttertoast.showToast(
                          msg: err.toString(), backgroundColor: Colors.blue);
                    }
                  }
                }
              },
              child: Container(
                width: mdq.width * 0.7,
                margin: const EdgeInsets.only(bottom: 10),
                height: mdq.height * 0.06,
                color: Colors.blue,
                child: _order == Order.paynow
                    ? const Center(
                        child: Text(
                          'Pay Now',
                          style: TextStyle(
                              color: whiteColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      )
                    : const Center(
                        child: Text(
                          'Order Now',
                          style: TextStyle(
                              color: whiteColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
