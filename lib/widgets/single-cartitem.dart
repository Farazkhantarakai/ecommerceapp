import 'package:ecommerce_app/models/cartmodel.dart';
import 'package:ecommerce_app/providers/cartitem.dart';
import 'package:ecommerce_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SingleCartItem extends StatefulWidget {
  SingleCartItem({super.key, required this.itemKey});
  String itemKey;
  @override
  State<SingleCartItem> createState() => _SingleCartItemState();
}

class _SingleCartItemState extends State<SingleCartItem> {
  @override
  Widget build(BuildContext context) {
    var cartModel = Provider.of<CartModel>(context, listen: true);
    var cartItem = Provider.of<CartItem>(context, listen: true);
    return GestureDetector(
      onLongPress: () {
        cartItem.changeLongPress();
      },
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
            width: double.infinity,
            height: 100,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      width: 60,
                      height: double.infinity,
                      decoration: const BoxDecoration(),
                      child: Center(
                          child: Image.network(
                        cartModel.image.toString(),
                      ))),
                  Container(
                    width: 170,
                    height: double.infinity,
                    decoration: const BoxDecoration(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        LimitedBox(
                          maxWidth: double.infinity,
                          maxHeight: 30,
                          child: Text(
                            '${cartModel.title}',
                            style: const TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '\$',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${cartModel.price}',
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 50,
                    height: double.infinity,
                    decoration: const BoxDecoration(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (cartModel.quantity!.toInt() <= 1) {
                              cartModel.quantity = 1;
                              showSnackBar(context,
                                  'Item can not be less than for checkout');
                            } else {
                              cartModel.decreaseValue();
                              CartModel cm = CartModel(
                                  cartModel.id,
                                  cartModel.title,
                                  cartModel.image,
                                  cartModel.price,
                                  cartModel.size,
                                  cartModel.color,
                                  cartModel.perOff,
                                  cartModel.quantity,
                                  false,
                                  widget.itemKey);

                              cartItem.updataCartItem(cm, context);
                            }
                          },
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 255, 255, 255),
                                shape: BoxShape.circle),
                            child: const Center(
                                child: Text(
                              '-',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            )),
                          ),
                        ),
                        Text(
                          '${cartModel.quantity}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        GestureDetector(
                          onTap: () {
                            cartModel.increaseValue();
                            CartModel cm = CartModel(
                                cartModel.id,
                                cartModel.title,
                                cartModel.image,
                                cartModel.price,
                                cartModel.size,
                                cartModel.color,
                                cartModel.perOff,
                                cartModel.quantity,
                                false,
                                widget.itemKey);

                            cartItem.updataCartItem(cm, context);
                          },
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 124, 209, 235),
                                shape: BoxShape.circle),
                            child: const Center(
                                child: Text(
                              '+',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          cartItem.isLongPress
              ? Positioned(
                  top: 5,
                  child: Checkbox(
                      value: cartModel.isChecked,
                      onChanged: (value) {
                        setState(() {
                          cartModel.changeChecked();
                          CartModel cm = CartModel(
                              cartModel.id,
                              cartModel.title,
                              cartModel.image,
                              cartModel.price,
                              cartModel.size,
                              cartModel.color,
                              cartModel.perOff,
                              cartModel.quantity,
                              false,
                              widget.itemKey);
                          if (cartModel.isChecked == true) {
                            cartItem.addDeletingCartItem(cm);
                          } else {
                            cartItem.removeDeletingCartItem(cm);
                          }
                        });
                      }))
              : Container()
        ],
      ),
    );
  }
}
