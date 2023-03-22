import 'package:ecommerce_app/providers/auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool darkMode = false;

  @override
  Widget build(BuildContext context) {
    final mdq = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 235, 234, 234),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 235, 234, 234),
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: mdq.height * 0.1,
          ),
          Stack(
            children: [
              const CircleAvatar(
                maxRadius: 70,
                backgroundImage: AssetImage('assets/icons/unknow.png'),
              ),
              Positioned(
                bottom: 10,
                right: -3,
                child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.add_a_photo,
                      color: Colors.white,
                    )),
              )
            ],
          ),
          SizedBox(
            height: mdq.height * 0.03,
          ),
          const Center(
              child: Text(
            'Faraz khan',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
          )),
          SizedBox(
            height: mdq.height * 0.03,
          ),
          const Text(
            'farazkhantaraka@gmail.com',
            style: TextStyle(
                color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              !darkMode
                  ? const Text(
                      'Switch to DarkMode',
                      style: TextStyle(
                          fontSize: 19,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold),
                    )
                  : const Text(
                      'Switch to LightMode',
                      style: TextStyle(
                          fontSize: 19,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold),
                    ),
              Switch(
                  value: darkMode,
                  onChanged: (value) {
                    setState(() {
                      darkMode = value;
                    });
                    if (kDebugMode) {
                      print(darkMode);
                    }
                  }),
            ],
          ),
          // Container(
          //   width: mdq.width * 0.7,
          //   height: mdq.height * 0.07,
          //   margin: EdgeInsets.only(top: mdq.height * 0.04),
          //   decoration: const BoxDecoration(
          //       color: Colors.blue,
          //       borderRadius: BorderRadius.all(Radius.circular(10))),
          //   child: const Center(
          //     child: Text(
          //       'Update Info',
          //       style:
          //           TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          //     ),
          //   ),
          // ),
          // GestureDetector(
          //   onTap: () {
          //     Provider.of<Auth>(context).logOut();
          //   },
          //   child: Container(
          //     width: mdq.width * 0.7,
          //     height: mdq.height * 0.07,
          //     margin: EdgeInsets.only(top: mdq.height * 0.03),
          //     decoration: const BoxDecoration(
          //         color: Colors.blue,
          //         borderRadius: BorderRadius.all(Radius.circular(10))),
          //     child: const Center(
          //       child: Text(
          //         'Log Out',
          //         style: TextStyle(
          //             color: Colors.white, fontWeight: FontWeight.bold),
          //       ),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
