import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showSnackBar(BuildContext context, content) {
  SnackBar snackBar = SnackBar(
    content: Text(
      content.toString(),
      style: const TextStyle(
          color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
    ),
    backgroundColor: Colors.white,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void showToast(BuildContext context, title) {
  Fluttertoast.showToast(msg: title.toString(), backgroundColor: Colors.black);
}

void dialogue(BuildContext context, message) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Ok'))
          ],
        );
      });
}
