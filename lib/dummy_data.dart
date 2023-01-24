import 'dart:convert';

import 'package:ecommerce_app/models/Product.dart';
import 'package:ecommerce_app/models/item.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Products extends ChangeNotifier {
  List<ProductModel> data = [];
  // = [
  //   Item(
  //       '1',
  //       'Mens Jordan1 high retro',
  //       'this retro is for mens only they can buy it',
  //       'sneaker',
  //       8.0,
  //       [
  //         'https://m.media-amazon.com/images/W/WEBP_402378-T2/images/I/61s9NYYXk+L._AC_UL1140_.jpg',
  //         'https://m.media-amazon.com/images/W/WEBP_402378-T2/images/I/61KcJpn2ugL._AC_UL1140_.jpg',
  //         'https://m.media-amazon.com/images/W/WEBP_402378-T2/images/I/61QskRhfE4L._AC_UL1140_.jpg'
  //       ],
  //       300,
  //       false,
  //       '0',
  //       [Colors.brown, Colors.green, Colors.blue],
  //       [6, 7, 8, 9]),
  //   Item(
  //       '2',
  //       'Nike Air force 1 low white black men',
  //       'Nike air force is for mens',
  //       'sneaker',
  //       9.0,
  //       [
  //         'https://m.media-amazon.com/images/W/WEBP_402378-T2/images/I/51nkL83EGBL._AC_UL1196_.jpg',
  //         'https://m.media-amazon.com/images/W/WEBP_402378-T2/images/I/51AIOQSvOcL._AC_.jpg',
  //         'https://m.media-amazon.com/images/W/WEBP_402378-T2/images/I/61akOKYM9WL._AC_UL1197_.jpg',
  //       ],
  //       340,
  //       false,
  //       '20',
  //       [Colors.brown, Colors.green, Colors.blue],
  //       [6, 7, 8, 9]),
  //   Item(
  //       '3',
  //       'Nike BasketBall Sheo',
  //       '',
  //       'sneaker',
  //       2.0,
  //       [
  //         'https://m.media-amazon.com/images/W/WEBP_402378-T2/images/I/81uiWMk9dnL._AC_UL1500_.jpg',
  //         'https://m.media-amazon.com/images/W/WEBP_402378-T2/images/I/71ubczQ2ltL._AC_UL1500_.jpg',
  //         'https://m.media-amazon.com/images/W/WEBP_402378-T2/images/I/81qEBo6FSpL._AC_UL1500_.jpg'
  //       ],
  //       5000,
  //       false,
  //       '0',
  //       [Colors.brown, Colors.green, Colors.blue],
  //       [6, 7, 8, 9]),
  //   Item(
  //       '4',
  //       'Nike Womans Air Jordan 1',
  //       'this is only for woman only they are able to buy it',
  //       'sneaker',
  //       7.6,
  //       [
  //         'https://m.media-amazon.com/images/W/WEBP_402378-T2/images/I/61brMhk6DaL._AC_UL1500_.jpg',
  //         'https://m.media-amazon.com/images/W/WEBP_402378-T2/images/I/61MWTV7aRRL._AC_UL1500_.jpg',
  //         'https://m.media-amazon.com/images/W/WEBP_402378-T2/images/I/61H3DTRhuSL._AC_UL1500_.jpg'
  //       ],
  //       340,
  //       false,
  //       '0',
  //       [Colors.brown, Colors.green, Colors.blue],
  //       [6, 7, 8, 9]),
  //   Item(
  //       '5',
  //       'Samsung Galaxy Watch 5 Pro',
  //       'its a good phone with good specs',
  //       'watch',
  //       8.0,
  //       [
  //         'https://m.media-amazon.com/images/W/WEBP_402378-T2/images/I/61Sl+xoVHoL._AC_SX425_.jpg',
  //         'https://m.media-amazon.com/images/W/WEBP_402378-T2/images/I/61wzxeeYglL._AC_SX425_.jpg',
  //         'https://m.media-amazon.com/images/W/WEBP_402378-T2/images/I/61Su0aM8NoL._AC_SX425_.jpg'
  //       ],
  //       340,
  //       false,
  //       '0',
  //       [Colors.black, const Color.fromARGB(255, 243, 213, 115), Colors.white],
  //       [6, 7, 8, 9]),
  //   Item(
  //       '6',
  //       'Samsung Galaxy Watch 4 Pro',
  //       'its a good watch with good specs',
  //       'watch',
  //       7.0,
  //       [
  //         'https://m.media-amazon.com/images/W/WEBP_402378-T2/images/I/51J31pakEUL._AC_SX425_.jpg',
  //         'https://m.media-amazon.com/images/W/WEBP_402378-T2/images/I/61nt5H-LdNL._AC_SX425_.jpg',
  //         'https://m.media-amazon.com/images/W/WEBP_402378-T2/images/I/61oJ9Z9XaiL._AC_SX425_.jpg'
  //       ],
  //       340,
  //       false,
  //       '0',
  //       [Colors.black, Colors.cyan, Colors.white],
  //       [6, 7, 8, 9]),
  //   Item(
  //       '7',
  //       'German Venu 2s ',
  //       'an outstading watch i have every seen',
  //       'watch',
  //       9.0,
  //       [
  //         'https://m.media-amazon.com/images/W/WEBP_402378-T2/images/I/61lY5G+In6L._AC_SX679_.jpg',
  //         'https://m.media-amazon.com/images/W/WEBP_402378-T2/images/I/41tDQFIdCXL._AC_SX679_.jpg'
  //       ],
  //       340,
  //       false,
  //       '0',
  //       [
  //         Colors.black,
  //         Colors.white,
  //       ],
  //       [6, 7, 8, 9]),
  //   Item(
  //       '8',
  //       'Fosil Gen 6',
  //       'a good fosil watch',
  //       'watch',
  //       8.0,
  //       [
  //         'https://m.media-amazon.com/images/W/WEBP_402378-T2/images/I/41oCWJUITwL._AC_.jpg',
  //         'https://m.media-amazon.com/images/W/WEBP_402378-T2/images/I/31sIuTqaXpL._AC_.jpg',
  //         'https://m.media-amazon.com/images/W/WEBP_402378-T2/images/I/41b5AGdNk1L._AC_.jpg'
  //       ],
  //       3040,
  //       false,
  //       '0',
  //       [Colors.white, Colors.black, Colors.brown],
  //       [6, 7, 8, 9]),
  //   Item(
  //       '9',
  //       'Carhartt 35L Triple-Compartment Backpack Carhartt Brown',
  //       'a bag with for heavy duties',
  //       'backpack',
  //       7.0,
  //       [
  //         'https://m.media-amazon.com/images/W/WEBP_402378-T2/images/I/91-UN4JHGFL._AC_SX425_.jpg',
  //         'https://m.media-amazon.com/images/W/WEBP_402378-T2/images/I/914IpSYlU2L._AC_SX425_.jpg',
  //         'https://m.media-amazon.com/images/W/WEBP_402378-T2/images/I/91PtrRorfXL._AC_SX425_.jpg'
  //       ],
  //       30000,
  //       false,
  //       '10',
  //       [Colors.brown, Colors.black, Colors.white],
  //       [30, 54, 230]),
  //   Item(
  //       '10',
  //       'MATEIN Travel Laptop Backpack',
  //       'this bag is only for laptop and their gagdet carrying',
  //       'backpack',
  //       7.0,
  //       [
  //         'https://m.media-amazon.com/images/W/WEBP_402378-T2/images/I/71nOxkaeCbL._AC_SX425_.jpg',
  //         'https://m.media-amazon.com/images/W/WEBP_402378-T2/images/I/81OFxhFWmML._AC_SY450_.jpg',
  //         'https://m.media-amazon.com/images/W/WEBP_402378-T2/images/I/71Y1ru0ocfL._AC_SX425_.jpg',
  //       ],
  //       340,
  //       false,
  //       '0',
  //       [Colors.yellow, Colors.grey, Colors.black]),
  //   Item(
  //       '11',
  //       'Maelstrom 40-50L Carry on Backpack',
  //       'Humo carry is  a good tool for buying',
  //       'backpack',
  //       7.0,
  //       [
  //         'https://m.media-amazon.com/images/W/WEBP_402378-T2/images/I/91xVvmSKTCL._AC_SX425_.jpg',
  //         'https://m.media-amazon.com/images/W/WEBP_402378-T2/images/I/81Bi7bmtiSL._AC_SX425_.jpg',
  //         'https://m.media-amazon.com/images/W/WEBP_402378-T2/images/I/81fH3oyFKML._AC_SX425_.jpg',
  //       ],
  //       79,
  //       false,
  //       '0',
  //       [Colors.green, Colors.black, Colors.blue]),
  //   // Item('12', '', 'watch', 7.0, ['', '', '', ''], 340, false, '0'),
  //   // Item('13', '', 'watch', 7.0, ['', '', '', ''], 340, false, '0'),
  //   // Item('14', '', 'watch', 7.0, ['', '', '', ''], 340, false, '0'),
  //   // Item('15', '', 'watch', 7.0, ['', '', '', ''], 340, false, '0'),
  //   // Item('16', '', 'watch', 7.0, ['', '', '', ''], 340, false, '70%'),
  //   // Item('17', '', 'watch', 7.0, ['', '', '', ''], 340, false, '0'),
  //   // Item('18', '', 'watch', 7.0, ['', '', '', ''], 340, false, '0'),
  //   // Item('19', '', 'watch', 7.0, ['', '', '', ''], 340, false, '25%'),
  //   // Item('20', '', 'watch', 7.0, ['', '', '', ''], 340, false, '0'),
  // ];
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
    String url =
        'https://ecommerceapp-1754f-default-rtdb.firebaseio.com/Product.json';
    var response = await http.get(Uri.parse(url));
    var result = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (var item in result) {
        var singleItem = ProductModel.fromJson(item);
        data.add(singleItem);
      }
    }

    notifyListeners();
  }
}
