import 'dart:async';
import 'dart:convert';
import 'package:ecommerce_app/models/httpexception.dart';
import 'package:ecommerce_app/models/order.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Orders extends ChangeNotifier {
  List<OrderItem> orderItems = [];
  String? tokenId;
  String? userId;
  Orders(this.tokenId, this.userId);
  List<OrderItem> get orderItem => orderItems;

  Future<String> addOrderItem(
      {required String amounts,
      required String id,
      required int dateTime,
      required products,
      required String status,
      required String name,
      required String address,
      required String email,
      required String paymentMethod}) async {
    String httpRes = '';
    final url =
        'https://ecommerceapp-1754f-default-rtdb.firebaseio.com/orders.json?auth=$tokenId';
    try {
      final response = await http.post(Uri.parse(url),
          body: jsonEncode({
            'id': id,
            'amount': amounts,
            'products': products,
            'time': dateTime,
            'status': status,
            'name': name,
            'address': address,
            'email': email,
            'payment_method': paymentMethod,
          }));

      final result = jsonDecode(response.body);
      if (kDebugMode) {
        print('here at order $result');
      }
      if (result['error'] != null) {
        throw HttpException(result['error']);
      }
      if (response.statusCode == 200) {
        httpRes = 'Success';
      }
    } catch (err) {
      throw HttpException(err.toString());
    }
    notifyListeners();
    return httpRes;
  }

  Future<void> fetchAndSetProduct() async {
    String url =
        'https://ecommerceapp-1754f-default-rtdb.firebaseio.com/orders.json?auth=$tokenId';
    try {
      final response = await http.get(Uri.parse(url));
      List<OrderItem> loadedProduct = [];
      final extractedData = jsonDecode(response.body);

      // ignore: unnecessary_null_comparison
      if (extractedData == null) {
        return;
      }

      if (extractedData['error'] != null) {
        if (kDebugMode) {
          print('error message is printed');
        }
        notifyListeners();
      }

      if (response.statusCode == 200) {
        extractedData.forEach((productId, productData) {
          loadedProduct.add(OrderItem(
              id: productId,
              amounts: productData['amount'],
              address: productData['address'],
              email: productData['email'],
              paymentMethod: productData['payment_method'],
              dateTime: productData['time'],
              name: productData['name'],
              status: productData['status'],
              products: productData['products']));
        });
        orderItems = loadedProduct;
      }
    } catch (err) {
      throw HttpException(err.toString());
    }
  }

  deletOrder(String orderId) async {
    if (kDebugMode) {
      print('item deleted');
    }
    final response = await http.delete(Uri.parse(
        'https://ecommerceapp-1754f-default-rtdb.firebaseio.com/orders/$orderId.json?auth=$tokenId'));

    var result = jsonDecode(response.body);

    if (kDebugMode) {
      print(response);
    }

    notifyListeners();
  }
}
