import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class ProductModel extends ChangeNotifier {
  String? category;
  List<dynamic>? colors;
  String? description;
  String? id;
  List<dynamic>? imageUrl;
  String? off;
  String? price;
  String? rating;
  List<dynamic>? size;
  String? title;
  bool? isFavourite;

  ProductModel({
    this.category,
    this.colors,
    this.description,
    this.id,
    this.imageUrl,
    this.off,
    this.price,
    this.rating,
    this.size,
    this.title,
    this.isFavourite = false,
  });

  ProductModel.fromJson(Map<String, dynamic> data) {
    category = data['category'];
    id = data['id'];
    colors = data['colors'];
    description = data['description'];
    imageUrl = data['image_url'];

    off = data['off'];
    price = data['price'];
    rating = data['rating'];
    size = data['size'];
    title = data['title'];
    isFavourite = data['isFavourite'] ?? false;
  }

  _saveStatus(newValue) {
    isFavourite = newValue;
    notifyListeners();
  }

  toggleFavourite(newId, authToken) async {
    final oldStatus = isFavourite;
    isFavourite = !isFavourite!;
    notifyListeners();
    String url =
        'https://ecommerceapp-1754f-default-rtdb.firebaseio.com/Product/$newId.json';

    try {
      var response = await http.patch(Uri.parse(url),
          body: jsonEncode({"isFavourite": isFavourite}));
      //this means that the status code is not 200
      if (response.statusCode >= 400) {
        if (kDebugMode) {
          print('i am here');
        }
        _saveStatus(oldStatus);
      }
      notifyListeners();
    } catch (err) {
      _saveStatus(oldStatus);
    }

    notifyListeners();
  }
}
