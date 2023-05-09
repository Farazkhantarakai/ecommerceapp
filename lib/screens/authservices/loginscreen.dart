import 'package:ecommerce_app/models/httpexception.dart';
import 'package:ecommerce_app/providers/auth.dart';
import 'package:ecommerce_app/screens/authservices/forgot_passwod.dart';
import 'package:ecommerce_app/screens/authservices/signupscreen.dart';
import 'package:ecommerce_app/utils/utils.dart';
import 'package:ecommerce_app/widgets/circlepainter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:provider/provider.dart';

import '../../utils/constants.dart';

// import 'dart:math' as math;

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  static const routName = 'login';

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  bool? isloading = false;
  static final formKey = GlobalKey<FormState>();
  static final _key1 = GlobalKey();
  static final _key2 = GlobalKey();
  bool showCharacter = true;
  static final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var mdq = MediaQuery.of(context).size;
    var auth = Provider.of<Auth>(context);
    return Scaffold(
        key: scaffoldKey,
        resizeToAvoidBottomInset: true,
        backgroundColor: whiteColor,
        body: isloading!
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              )
            : Stack(
                children: [
                  Container(
                      width: double.infinity,
                      height:
                          (mdq.height - MediaQuery.of(context).padding.top) *
                              0.35,
                      decoration: const BoxDecoration(color: blueColor),
                      child: Stack(children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Center(
                                child: Container(
                                  padding: const EdgeInsets.only(left: 20),
                                  decoration: const BoxDecoration(),
                                  child: const Text(
                                    'Welcome back',
                                    style: TextStyle(
                                        fontSize: 60,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Positioned(
                            top: -30,
                            right: 50,
                            child: Container(
                              width: 80,
                              height: 80,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromARGB(255, 245, 192, 151),
                              ),
                            )),
                        Positioned(
                          top: 20,
                          left: 100,
                          child: CustomPaint(
                            painter: CirclePainter(radius1: 14, radius2: 9),
                          ),
                        ),
                        Positioned(
                          bottom: 50,
                          right: 100,
                          child: CustomPaint(
                            painter: CirclePainter(radius1: 25, radius2: 15),
                          ),
                        )
                      ])),

                  //login screen
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                        width: double.infinity,
                        height: mdq.height * 0.6,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20))),
                        child: SingleChildScrollView(
                          child: Form(
                            key: formKey,
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                    'Login',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: mdq.height * 0.05,
                                  ),
                                  Container(
                                    // padding: EdgeInsets.only(
                                    //     top: 5,
                                    //     bottom: MediaQuery.of(context)
                                    //         .viewInsets
                                    //         .bottom),
                                    width: double.infinity,
                                    height: mdq.height * 0.1,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: const [
                                            Icon(
                                              Icons.email,
                                              color: Colors.grey,
                                            ),
                                            Text(
                                              'Email',
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            )
                                          ],
                                        ),
                                        Expanded(
                                          child: TextFormField(
                                            key: _key1,
                                            controller: _emailController,
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            decoration: const InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        vertical: 2,
                                                        horizontal: 2)),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'email should not be empty';
                                              } else if (!value
                                                  .endsWith('@gmail.com')) {
                                                return 'write @ gmail.com at the end ';
                                              }
                                              return null;
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: mdq.height * 0.05,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(top: 5),
                                    width: double.infinity,
                                    height: mdq.height * 0.1,
                                    decoration: const BoxDecoration(),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: const [
                                            Icon(
                                              Icons.lock,
                                              color: Colors.grey,
                                            ),
                                            Text(
                                              'Password',
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            )
                                          ],
                                        ),
                                        Expanded(
                                          child: TextFormField(
                                            // key: _key2,
                                            controller: _passwordController,
                                            obscureText:
                                                showCharacter ? true : false,
                                            decoration: InputDecoration(
                                                suffix: Text.rich(TextSpan(
                                                    text: showCharacter
                                                        ? 'Show'
                                                        : 'Hide',
                                                    style: const TextStyle(
                                                        color: Colors.blue),
                                                    recognizer:
                                                        TapGestureRecognizer()
                                                          ..onTap = () {
                                                            setState(() {
                                                              showCharacter =
                                                                  !showCharacter;
                                                            });
                                                          })),
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 0,
                                                        horizontal: 2),
                                                fillColor: Colors.green),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'value cannot be empty';
                                              } else if (value.length < 6) {
                                                return 'it should be more than 6 characters';
                                              }
                                              return null;
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, ForgotPassword.routName);
                                    },
                                    child: const Text(
                                      'Forgot Password?',
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                  ),
                                  SizedBox(
                                    height: mdq.height * 0.04,
                                  ),
                                  Center(
                                    child: InkWell(
                                      onTap: () async {
                                        if (formKey.currentState!.validate()) {
                                          formKey.currentState!.save();
                                          setState(() {
                                            isloading = true;
                                          });
                                          try {
                                            await auth
                                                .logInUser(
                                                    _emailController.text,
                                                    _passwordController.text)
                                                .then((value) {
                                              setState(() {
                                                isloading = false;
                                              });
                                            });
                                          } on HttpException catch (err) {
                                            showSnackBar(context,
                                                err.message.toString());
                                          }
                                        }
                                      },
                                      child: Container(
                                        width: mdq.width * 0.6,
                                        height: 60,
                                        decoration: const BoxDecoration(
                                            color: Color.fromARGB(
                                                255, 88, 104, 245),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        child: const Center(
                                            child: Text(
                                          'LogIn',
                                          style: TextStyle(color: Colors.white),
                                        )),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: mdq.height * 0.03,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, SignUpScreen.routName);
                                    },
                                    child: const Center(
                                      child: Text(
                                        'Create Account',
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )),
                  )
                ],
              ));
  }
}
