import 'package:ecommerce_app/models/Product.dart';
import 'package:ecommerce_app/models/cartmodel.dart';
import 'package:ecommerce_app/providers/cartitem.dart';
import 'package:ecommerce_app/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({super.key, required this.tak});
  final ProductModel tak;

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  Color? selectColor;
  int? size;
  int clickedIndex = 0;
  int? colorIndex = 0;
  generatBox(length, item) {
    return List.generate(
        length,
        (index) => GestureDetector(
              onTap: () {
                setState(() {
                  size = item[index];
                  clickedIndex = index; //
                });
                if (kDebugMode) {
                  print('item size is $size');
                }
              },
              child: Container(
                margin: const EdgeInsets.all(4),
                width: 50,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: index == clickedIndex
                      ? const Color.fromARGB(255, 174, 196, 233)
                      : null,
                ),
                child: Center(
                  child: Text(
                    'US ${item[index]}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ));
  }

  //List generate method will create exactly the same item of the length
  generateColor(length, List<dynamic>? colorItem) {
    return List.generate(
        length,
        (index) => GestureDetector(
              onTap: () {
                setState(() {
                  colorIndex = index;
                  selectColor = ToColor.fromHex(colorItem[index]);
                });
              },
              child: Container(
                margin: const EdgeInsets.only(left: 10),
                constraints: const BoxConstraints.expand(width: 34, height: 34),
                decoration: BoxDecoration(
                  color: ToColor.fromHex(colorItem![index]),
                  shape: BoxShape.circle,
                ),
                child: colorIndex == index
                    ? const Icon(
                        Icons.check,
                        color: Colors.white,
                      )
                    : null,
              ),
            )).toList();
  }

  @override
  Widget build(BuildContext context) {
    var cartItem = Provider.of<CartItem>(context, listen: false);

    return LayoutBuilder(builder: (context, ctx) {
      return Stack(
        children: [
          // product detail portion
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              constraints: BoxConstraints.expand(
                width: double.infinity,
                height: ctx.maxHeight * 0.7,
              ),
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 226, 223, 223),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(35),
                      topRight: Radius.circular(35))),
              child: Padding(
                padding: const EdgeInsets.only(top: 5, right: 10, left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: ctx.maxHeight * 0.04,
                    ),
                    Row(
                      children: [
                        LimitedBox(
                          maxWidth: 250,
                          child: Text(
                            widget.tak.title.toString(),
                            softWrap: false,
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: Text(
                            '(${widget.tak.rating})',
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: ctx.maxHeight * 0.04,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${widget.tak.description}',
                            maxLines: 2,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 112, 112, 112)),
                          ),
                          SizedBox(
                            height: ctx.maxHeight * 0.08,
                          ),
                          SingleChildScrollView(
                            child: Row(
                              children: [
                                const Text(
                                  'Size:',
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.grey),
                                ),

                                //this will size boxes
                                ...generatBox(
                                    widget.tak.size!.length, widget.tak.size)
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SingleChildScrollView(
                            child: Row(
                              children: [
                                const Text('Available Colors:',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.grey)),
                                // this will create the color boxes
                                ...generateColor(widget.tak.colors!.length,
                                    widget.tak.colors)
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),

          // add to cart button portion
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(top: ctx.maxHeight * 0.1),
              width: double.infinity,
              height: ctx.maxHeight * 0.2,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Row(
                    children: [
                      Text(
                        '\$${widget.tak.price}',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () async {
                          Color firstColor =
                              ToColor.fromHex(widget.tak.colors![0]);
                          // print('id ${widget.tak.id}  title ${widget.tak.title}  imageurl ${widget.tak.imageUrl![0] } price ${widget.tak.price} size $size ');
                          CartModel cm = CartModel(
                              widget.tak.id,
                              widget.tak.title,
                              widget.tak.imageUrl![0].toString(),
                              double.parse(widget.tak.price.toString()),
                              size ?? widget.tak.size![0],
                              selectColor?.value.toInt() ?? firstColor.value,
                              widget.tak.off == '0'
                                  ? 0
                                  : int.parse(widget.tak.off.toString()),
                              1);
                          String result =
                              await cartItem.addCartItem(cm, context);
                          if (result == 'success') {
                            Fluttertoast.showToast(
                              msg: 'Item Added To Cart',
                              backgroundColor: Colors.blue.shade400,
                              textColor: Colors.white,
                            );
                            await cartItem.fetchCartItem();
                          }
                        },
                        child: Container(
                          width: 150,
                          height: ctx.maxHeight * 0.1,
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 236, 236, 236),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          child: Consumer<CartItem>(
                            builder: (context, ct, child) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.shopping_cart,
                                    color: Colors.grey,
                                  ),
                                  Text(
                                    'Add to Cart',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      );
    });
  }
}
