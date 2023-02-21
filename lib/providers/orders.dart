import 'dart:async';
import 'dart:convert';
import 'package:ecommerce_app/models/cartmodel.dart';
import 'package:ecommerce_app/models/httpexception.dart';
import 'package:ecommerce_app/models/order.dart';
import 'package:ecommerce_app/screens/check_out_screen.dart';
import 'package:ecommerce_app/utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class Orders extends ChangeNotifier {
  List<OrderItem> _orderItems = [];
  String? tokenId;
  String? userId;
  Orders(this.tokenId, this.userId);
  List<OrderItem> get orderItem => _orderItems;

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
      final extractedData = jsonDecode(response.body) as Map<String, dynamic>;

      if (extractedData == null) {
        return;
      }

      extractedData.forEach((productId, productData) {
        if (productData['products'] != null) {
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
        }
      });

      _orderItems = loadedProduct;

      notifyListeners();
    } catch (err) {
      throw HttpException(err.toString());
    }
  }
}
