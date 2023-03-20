import 'dart:convert';

import 'package:ecommerce_app/models/Product.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class Products extends ChangeNotifier {
  List<ProductModel> data = [];
  bool isClicked = false;
  List<ProductModel> cData = [];
  List<ProductModel> mdata = [];
  String sortItem = '';

  String authToken;
  String userId;
  Products(this.authToken, this.userId);

  void setSortingItem(String clickedItem) {
    sortItem = clickedItem;
    notifyListeners();
  }

  List<ProductModel> get getProducts {
    if (!isClicked) {
      // if isClicked is false

      if (sortItem == 'title') {
        data.sort(((a, b) => a.title!.length.compareTo(b.title!.length)));
        return data;
      } else if (sortItem == 'price') {
        if (kDebugMode) {
          print('inside ');
        }
        data.sort((a, b) {
          return a.price!.compareTo(b.price!);
        });
        notifyListeners();
        return data;
      }

      return data;
    } else {
      // if isClicked is true
      if (sortItem == 'title') {
        mdata.sort(((a, b) => a.title!.length.compareTo(b.title!.length)));
        return mdata;
      } else if (sortItem == 'price') {
        mdata.sort((a, b) {
          return a.price!.compareTo(b.price!);
        });
        notifyListeners();
        return mdata;
      }

      return mdata;
    }
  }

  List<ProductModel> get getFavourites {
    return data.where((element) => element.isFavourite == true).toList();
  }

  //the product category will be a string
  selectProduct(String prodCateg) {
    cData = data;
    //this means that category is clicked once
    if (isClicked) {
      mdata = cData
          .where((element) =>
              element.category!.toLowerCase() == prodCateg.toLowerCase())
          .toList();
      isClicked = true;
      if (kDebugMode) {
        print(data);
      }
    } else {
      mdata = cData
          .where((element) =>
              element.category!.toLowerCase() == prodCateg.toLowerCase())
          .toList();
      isClicked = true;
    }
    notifyListeners();
  }

  Future<void> fetchAndSet() async {
    data = [];
    // ?auth=$authToken
    String url =
        'https://ecommerceapp-1754f-default-rtdb.firebaseio.com/Product.json';
    try {
      final response = await http.get(Uri.parse(url));
      final result = jsonDecode(response.body);

      if (result == null) {
        return;
      }
      // print(result);

      url =
          'https://ecommerceapp-1754f-default-rtdb.firebaseio.com/userFavourite/$userId.json?auth=$authToken';
      final favResponse = await http.get(
        Uri.parse(url),
      );

      final favResult = jsonDecode(favResponse.body);
      // ignore: unnecessary_null_comparison

      List<ProductModel> loadedProduct = [];
      if (response.statusCode == 200) {
        if (favResult == null) {
          result.forEach((item) {
            loadedProduct.add(ProductModel(
                id: item['id'],
                category: item['category'],
                colors: item['colors'],
                description: item['description'],
                imageUrl: item['image_url'],
                off: item['off'],
                price: item['price'],
                size: item['size'],
                title: item['title'],
                rating: item['rating'],
                isFavourite: false));
          });
        } else {
          result.forEach((item) {
            final favorite = favResult[item['id'].toString()];

            loadedProduct.add(ProductModel(
                id: item['id'],
                category: item['category'],
                colors: item['colors'],
                description: item['description'],
                imageUrl: item['image_url'],
                off: item['off'],
                price: item['price'],
                size: item['size'],
                title: item['title'],
                rating: item['rating'],
                isFavourite: favorite == null
                    ? false
                    : favorite['isFavourite'] ?? false));
          });
        }

        data = loadedProduct;
      }
    } catch (err) {
      Fluttertoast.showToast(msg: err.toString());
    }
  }
}
