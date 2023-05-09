import 'package:ecommerce_app/models/Product.dart';
import 'package:ecommerce_app/providers/dummy_data.dart';
import 'package:ecommerce_app/screens/detailscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/imagebgclipper.dart';

// ignore: must_be_immutable
class SingleGridItem extends StatefulWidget {
  SingleGridItem({
    super.key,
    required this.ctx,
    // required this.singleItem
    required this.value,
  });
  final BoxConstraints ctx;
  int value;

  @override
  State<SingleGridItem> createState() => _SingleGridItemState();
}

Color getColor(String color) {
  Color newColor = Color(int.parse('ff${color.substring(1)}', radix: 16));
  return newColor;
}

class _SingleGridItemState extends State<SingleGridItem> {
  @override
  Widget build(BuildContext context) {
    var ite = Provider.of<ProductModel>(context, listen: true);
    var prod = Provider.of<Products>(context, listen: false);

    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, DetailScreen.routName, arguments: ite);
      },
      child: Container(
          margin: const EdgeInsets.only(
            left: 4,
            right: 4,
            top: 2,
          ),
          padding: const EdgeInsets.all(4.0),
          constraints: const BoxConstraints.expand(),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(12))),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    ite.off.toString() == '0'
                        ? Container()
                        : Container(
                            constraints: BoxConstraints.expand(
                              width: widget.ctx.maxWidth * 0.12,
                              height: widget.ctx.maxHeight * 0.08,
                            ),
                            decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 147, 182, 243),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Center(
                                child: Text(
                              '${ite.off}%',
                              style: const TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold),
                            )),
                          ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          ite.toggleFavourite(
                              ite.id, prod.authToken, prod.userId);
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ite.isFavourite!
                            ? const Icon(
                                Icons.favorite,
                                color: Colors.red,
                              )
                            : const Icon(
                                Icons.favorite,
                                color: Colors.grey,
                              ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                    padding: const EdgeInsets.all(2.0),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 50,
                          left: 70,
                          child: CustomPaint(
                            painter: ImageBgPainter(
                                newColor: getColor(ite.colors![0]),
                                radius1: 65,
                                radius2: 55),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(widget.ctx.maxHeight * 0.03),
                          decoration: const BoxDecoration(),
                          width: double.infinity,
                          height: widget.ctx.maxHeight * 0.19,
                          child: Image.network(
                            ite.imageUrl![0],
                            height: 50,
                          ),
                        ),
                      ],
                    )),
              ),
              SizedBox(
                height: widget.ctx.maxHeight * 0.02,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: Text(
                  '${ite.title}',
                  softWrap: false,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 13),
                ),
              ),
              SizedBox(
                height: widget.ctx.maxHeight * 0.02,
              ),
              Text(
                '\$ ${ite.price}',
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Color.fromARGB(255, 3, 67, 121)),
              ),
            ],
          )),
    );
  }
}
