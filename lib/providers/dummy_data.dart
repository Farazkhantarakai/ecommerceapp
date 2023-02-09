import 'dart:convert';

import 'package:ecommerce_app/models/Product.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Products extends ChangeNotifier {
  List<ProductModel> data = [];
  bool isClicked = false;
  List<ProductModel> cData = [];
  List<ProductModel> mdata = [];
  String sortItem = '';

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
    String url =
        'https://ecommerceapp-1754f-default-rtdb.firebaseio.com/Product.json';
    var response = await http.get(Uri.parse(url));
    var result = jsonDecode(response.body.toString());
    if (kDebugMode) {
      print(result);
    }
    if (response.statusCode == 200) {
      for (Map<String, dynamic> item in result) {
        var singleItem = ProductModel.fromJson(item);
        data.add(singleItem);
      }
    }

    notifyListeners();
  }
}
