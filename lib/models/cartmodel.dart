import 'package:flutter/material.dart';

class CartModel with ChangeNotifier {
  final String? id;
  final String? title;
  final String? image;
  final double? price;
  final int? size;
  final Color? color;
  final int? perOff;
  int? quantity;
  bool? isChecked;
  CartModel(this.id, this.title, this.image, this.price, this.size, this.color,
      this.perOff, this.quantity,
      [this.isChecked = false]);

  void increaseValue() {
    quantity = quantity! + 1;
    notifyListeners();
  }

  void changeChecked() {
    isChecked = !isChecked!;
  }

  void decreaseValue() {
    quantity = quantity! - 1;
    notifyListeners();
  }
}
