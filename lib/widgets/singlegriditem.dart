import 'package:ecommerce_app/models/item.dart';
import 'package:ecommerce_app/screens/detailscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SingleGridItem extends StatelessWidget {
  const SingleGridItem({super.key, required this.ctx
      // required this.singleItem
      });
  final BoxConstraints ctx;
  // final Item singleItem;
  @override
  Widget build(BuildContext context) {
    var ite = Provider.of<Item>(context, listen: true);
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
          constraints: const BoxConstraints.expand(
              //  height: widget.ctx.maxHeight * 0.3,
              ),
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
                              width: ctx.maxWidth * 0.12,
                              height: ctx.maxHeight * 0.08,
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
                        ite.doFavorite();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ite.isFavorite
                            ? const Icon(
                                Icons.favorite,
                                color: Colors.red,
                                // size: 15,
                              )
                            : const Icon(
                                Icons.favorite,
                                color: Colors.grey,
                              ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                    // margin: const EdgeInsets.only(top: 25, bottom: 25),
                    padding: const EdgeInsets.all(2.0),
                    child: Stack(
                      children: [
                        Container(
                          padding: EdgeInsets.all(ctx.maxHeight * 0.03),
                          decoration: const BoxDecoration(),
                          width: double.infinity,
                          height: ctx.maxHeight * 0.2,
                          child: Image.network(
                            ite.images![0],
                            height: 50,
                          ),
                        ),
                      ],
                    )),
              ),
              SizedBox(
                height: ctx.maxHeight * 0.02,
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
                height: ctx.maxHeight * 0.02,
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
