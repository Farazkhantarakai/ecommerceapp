import 'package:ecommerce_app/main.dart';
import 'package:ecommerce_app/models/cartmodel.dart';
import 'package:ecommerce_app/models/httpexception.dart';
import 'package:ecommerce_app/models/order.dart';
import 'package:ecommerce_app/providers/cartitem.dart';
import 'package:ecommerce_app/providers/orders.dart';
import 'package:ecommerce_app/screens/cart.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../utils/constants.dart';
import 'package:pay/pay.dart';
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
  var _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    Map<String, CartModel> cartItem = data['cartItems'];
    var total = data['total'];
    final mdq = MediaQuery.of(context).size;
    var order = Provider.of<Orders>(context, listen: false);
    final cart = Provider.of<CartItem>(context, listen: false);
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        backgroundColor: whiteColor,
        title: const Text(
          'Add Order',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(),
              child: ListView(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 8.0, left: 12),
                    child: Text('Select your payment method: '),
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
                      ))
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
                    // OrderItem item = OrderItem(
                    //       id: const Uuid().v4().toString(),
                    //       amounts: total.toString(),
                    //       dateTime: DateTime.now().millisecondsSinceEpoch,
                    //       products: cartItem,
                    //       status: OrderItem.statusToString(Status.completed),
                    //       name: _nameController.text.toString(),
                    //       address: _addressController.text.toString(),
                    //       email: _emailController.text.toString());
                  } else {
                    // OrderItem item = OrderItem(
                    // id: const Uuid().v4().toString(),
                    // amounts: total.toString(),
                    // dateTime: DateTime.now().millisecondsSinceEpoch,
                    // products: cartItem,
                    // status: OrderItem.statusToString(Status.completed),
                    // name: _nameController.text.toString(),
                    // address: _addressController.text.toString(),
                    // email: _emailController.text.toString(),
                    // paymentMethod: 'Cash On Delivery'
                    // );
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
                        Navigator.pushNamed(context, MyHomeApp.routName);
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

  void onGooglePayResult(paymentResult) {
    // Send the resulting Google Pay token to your server / PSP
  }
}
