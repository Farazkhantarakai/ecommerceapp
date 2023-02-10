import 'dart:convert';
import 'package:ecommerce_app/models/cartmodel.dart';
import 'package:ecommerce_app/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CartItem extends ChangeNotifier {
  //we want to store it in a map like structure
  Map<String, CartModel> cartItem = {};
  int quantity = 0;
  Map<String, CartModel> get getCartItem {
    return {...cartItem};
  }

  String token;
  CartItem(this.token, this.cartItem);

  int get cartLength {
    return cartItem.length;
  }

  bool isLongPress = false;

  //this will store items for deleting from cart
  List<CartModel> deleteCartItem = [];

  double get getTotal {
    double result = 0;

    cartItem.forEach((key, value) {
      result += value.price! * value.quantity!;
    });

    return result;
  }

  changeLongPress() {
    isLongPress = !isLongPress;
    notifyListeners();
  }

  // int get getTotalTax {
  //   if (cartItem.isEmpty) {
  //     quantity = 0;
  //   } else {
  //     cartItem.forEach((key, value) {
  //       quantity++;
  //     });
  //   }
  //   return quantity;
  // }

  removeItemFromDeletion() {
    // deleteCartItem.forEach((value) {
    //   value.changeChecked();
    // });
    notifyListeners();
  }

  addDeletingCartItem(CartModel cm) {
    deleteCartItem.add(cm);
    if (kDebugMode) {
      print('adding item${cm.id}  added delete items are $deleteCartItem');
    }
    notifyListeners();
  }

  Future<void> doDeleteItems() async {
    deleteCartItem.forEach((element) async {
      String url =
          'https://ecommerceapp-1754f-default-rtdb.firebaseio.com/cart/${element.key}.json?auth=$token';
      var response = await http.delete(Uri.parse(url));
      // print(response.body);
      notifyListeners();
      if (response.statusCode == 200) {
        cartItem.remove(element.id);
      } else {
        throw Exception('Something Went Wrong');
      }
    });
  }

  removeDeletingCartItem(CartModel cm) {
    deleteCartItem.removeWhere((element) => element.id == cm.id);
    print('deleting item are $deleteCartItem');
    notifyListeners();
  }

  updataCartItem(CartModel cm, context) {
    if (cartItem.containsKey(cm.id)) {
      cartItem.update(cm.id.toString(), (value) => cm);
    }
    notifyListeners();
  }

  Future<void> fetchCartItem() async {
    String url =
        'https://ecommerceapp-1754f-default-rtdb.firebaseio.com/cart.json';
    var response = await http.get(Uri.parse(url));

    var result = jsonDecode(response.body);
    if (result == null) {
      cartItem = {};
      notifyListeners();
      return;
    }
    Map<String, CartModel> cartItems = {};
    result.forEach((key, value) {
      cartItems[key] = CartModel.fromJson(value);
    });
    cartItem = cartItems;
    // if (kDebugMode) {
    //   print(cartItem);
    // }
    notifyListeners();
  }

  Future<String> addCartItem(CartModel cm, context) async {
    if (kDebugMode) {
      print(cm.image);
    }
    var httpresponse = '';
    if (cartItem.containsKey(cm.id)) {
      SnackBar snackBar = const SnackBar(
        content: Text('Item already added'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      String url =
          'https://ecommerceapp-1754f-default-rtdb.firebaseio.com/cart.json';
      try {
        var response = await http.post(Uri.parse(url),
            body: jsonEncode({
              'id': cm.id,
              'title': cm.title,
              'image': cm.image,
              'size': cm.size,
              'price': cm.price,
              'color': cm.color!,
              'quantity': cm.quantity,
              'isChecked': cm.isChecked,
              'perOff': cm.perOff,
            }));
        var result = jsonDecode(response.body.toString());

        if (result['error'] != null) {
          dialogue(context, 'something went wrong please try again');
          notifyListeners();
        }

        if (response.statusCode == 200) {
          httpresponse = 'success';
          notifyListeners();
        }
      } catch (err) {
        dialogue(context, '$err');
      }
      notifyListeners();
    }
    notifyListeners();
    return httpresponse;
  }
}

// we have error response only for get and post while for the rest you have to do like
// if (response.statusCode >= 400)  it means that there is something wrong
// what jsonEncode do it convert  json to a String
//and jsonDecode do reversing of it like it convert string to a json
