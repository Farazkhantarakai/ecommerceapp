import 'package:flutter/cupertino.dart';

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
    colors = data['colors'] as List<dynamic>;
    description = data['description'];
    imageUrl = data['image_url'] as List<dynamic>;
    isFavourite = data['isFavourite'];
    off = data['off'];
    price = data['price'];
    rating = data['rating'];
    size = data['size'] as List<dynamic>;
    title = data['title'];
  }
}
