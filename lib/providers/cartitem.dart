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
    if (kDebugMode) {
      print('islong press $isLongPress');
    }
    notifyListeners();
  }

  int get getTotalTax {
    cartItem.forEach((key, value) {
      quantity = value.quantity!;
    });
    return quantity;
  }

  addDeletingCartItem(CartModel cm) {
    deleteCartItem.add(cm);
    notifyListeners();
  }

  doDeleteItems() async {
    deleteCartItem.forEach((element) async {
      String url =
          'https://completeecommerceapp-default-rtdb.firebaseio.com/cart/2.json';

      var response = await http.delete(Uri.parse(url));

      cartItem.remove(element.id);
    });
  }

  removeDeletingCartItem(CartModel cm) {
    deleteCartItem.remove(cm);
    notifyListeners();
  }

  updataCartItem(CartModel cm, context) {
    if (cartItem.containsKey(cm.id)) {
      cartItem.update(cm.id.toString(), (value) => cm);
    }
    notifyListeners();
  }

  Future<String> addCartItem(CartModel cm, context) async {
    var httpresponse = '';
    if (cartItem.containsKey(cm.id)) {
      SnackBar snackBar = const SnackBar(
        content: Text('Item already added'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      String url =
          'https://completeecommerceapp-default-rtdb.firebaseio.com/cart.json';
      try {
        var response = await http.post(Uri.parse(url),
            body: jsonEncode({
              'id': cm.id,
              'title': cm.title,
              'image': cm.image,
              'size': cm.size,
              'price': cm.price,
              'color': cm.color!.value,
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
          cartItem.putIfAbsent('${cm.id}', () => cm);
          // SnackBar snackBar = const SnackBar(
          //   content: Text('Item added to cart'),
          // );
          // ScaffoldMessenger.of(context).showSnackBar(snackBar);
          httpresponse = 'success';
          notifyListeners();
        }
      } catch (err) {
        dialogue(context, '$err');
      }
    }
    notifyListeners();
    return httpresponse;
  }
}
