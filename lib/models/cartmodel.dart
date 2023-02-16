import 'package:flutter/material.dart';

class CartModel with ChangeNotifier {
  String? key;
  int? id;
  String? title;
  String? image;
  double? price;
  int? size;
  int? color;
  int? perOff;
  int? quantity;
  bool? isChecked;
  CartModel(this.id, this.title, this.image, this.price, this.size, this.color,
      this.perOff, this.quantity,
      [this.isChecked = false, this.key]);

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

  CartModel.fromJson(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    image = map['image'];
    size = map['size'];
    price = map['price'];
    color = map['color'];
    quantity = map['quantity'];
    isChecked = map['isChecked'];
    perOff = map['perOff'];
  }
}
