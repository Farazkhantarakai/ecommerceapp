import 'package:ecommerce_app/models/httpexception.dart';
import 'package:ecommerce_app/providers/auth.dart';
import 'package:ecommerce_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({super.key});

  static const routName = '/forgotPassword';

  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);
    final mdq = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: blueColor,
        body: Stack(
          children: [
            Container(
                height: mdq.height * 0.5,
                decoration: const BoxDecoration(),
                child: Column(
                  children: [
                    SizedBox(
                      height: mdq.height * 0.06,
                    ),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.arrow_back,
                              color: whiteColor,
                            ))
                      ],
                    ),
                    SizedBox(
                      height: mdq.height * 0.15,
                    ),
                    const Text(
                      'Forgot Password',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ],
                )),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                height: mdq.height * 0.5,
                decoration: const BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10))),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: ListView(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: _passwordController,
                        decoration:
                            const InputDecoration(hintText: 'Enter your email'),
                      ),
                      GestureDetector(
                        onTap: () async {
                          try {
                            await auth.resetPassword(_passwordController.text);
                          } on HttpException catch (er) {
                            Fluttertoast.showToast(msg: er.toString());
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(top: 20),
                          height: 50,
                          decoration: const BoxDecoration(color: blueColor),
                          child: const Center(
                              child: Text(
                            'Change Password',
                            style: TextStyle(color: Colors.white),
                          )),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
