import 'package:ecommerce_app/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
            onPressed: () {
              Provider.of<Auth>(context, listen: false).logOut();
            },
            child: const Text('LogOut'))
      ],
    );
  }
}
