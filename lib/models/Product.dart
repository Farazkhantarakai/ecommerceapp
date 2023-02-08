import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ProductModel extends ChangeNotifier {
  String? category;
  List<dynamic>? colors;
  String? description;
  String? id;
  List<dynamic>? imageUrl;
  bool? isFavourite;
  String? off;
  String? price;
  String? rating;
  List<dynamic>? size;
  String? title;

  ProductModel(
      {this.category,
      this.colors,
      this.description,
      this.id,
      this.imageUrl,
      this.isFavourite,
      this.off,
      this.price,
      this.rating,
      this.size,
      this.title});

  ProductModel.fromJson(Map<String, dynamic> data) {
    category = data['category'];
    id = data['id'];
    colors = data['colors'];
    description = data['description'];
    imageUrl = data['image_url'];
    isFavourite = data['isFavourite'];
    off = data['off'];
    price = data['price'];
    rating = data['rating'];
    size = data['size'];
    title = data['title'];
  }

  saveStatus(newValue) {
    isFavourite = newValue;
    notifyListeners();
  }

  doFavourite() async {
    // this is optimistic way first
    final oldStatus = isFavourite;
    isFavourite = !isFavourite!;
    String url =
        'https://ecommerceapp-1754f-default-rtdb.firebaseio.com/Product/$id.json';
    try {
      var response = await http.patch(Uri.parse(url),
          body: jsonEncode({'isFavourite': isFavourite}));
      if (response.statusCode >= 400) {
        saveStatus(oldStatus);
        notifyListeners();
      }
    } catch (err) {
      saveStatus(oldStatus);
      notifyListeners();
    }
  }
}
