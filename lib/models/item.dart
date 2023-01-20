import 'package:flutter/material.dart';

class Item extends ChangeNotifier {
  String? id;
  String? title;
  String? description;
  String? category;
  double? rating;
  List<String>? images;

  double? price;
  bool isFavorite;
  String? off;
  List<Color>? colors;

  List<int>? size;
  Item(this.id, this.title, this.description, this.category, this.rating,
      this.images, this.price,
      [this.isFavorite = false, this.off, this.colors, this.size]);

  void doFavorite() {
    isFavorite = !isFavorite;
    // print(isFavorite);
    notifyListeners();
  }
}
