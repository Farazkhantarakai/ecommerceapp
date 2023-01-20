import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_app/models/item.dart';
import 'package:flutter/material.dart';

class CarousolContainer extends StatefulWidget {
  const CarousolContainer({super.key, required this.tak});
  final Item tak;

  @override
  State<CarousolContainer> createState() => _CarousolContainerState();
}

class _CarousolContainerState extends State<CarousolContainer> {
  int cindex = 0;

  indicator(imagesLength, currentIndex) {
    return List<Widget>.generate(imagesLength, (index) {
      return currentIndex != index
          ? Container(
              margin: const EdgeInsets.all(3),
              width: 10,
              height: 20,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromARGB(255, 233, 231, 231),
              ),
            )
          : Container(
              constraints: const BoxConstraints.expand(
                width: 40,
                height: 10,
              ),
              decoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(12))),
            );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, ctx) {
      return Container(
          constraints: const BoxConstraints.expand(
              width: double.infinity, height: double.infinity),
          decoration: const BoxDecoration(color: Colors.white),
          child: Column(
            children: [
              //this is carousal container
              widget.tak.off.toString() == '0'
                  ? Container(
                      constraints: BoxConstraints.expand(
                          width: 50, height: ctx.maxHeight * 0.1))
                  : Container(
                      margin: const EdgeInsets.only(top: 5),
                      constraints: BoxConstraints.expand(
                          width: 50, height: ctx.maxHeight * 0.1),
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 165, 194, 245),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Center(
                          child: Text(
                        '${widget.tak.off}%',
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ))),
              Container(
                margin: const EdgeInsets.only(top: 10),
                constraints: BoxConstraints.expand(
                    width: double.infinity, height: ctx.maxHeight * 0.7),
                child: CarouselSlider(
                    items: widget.tak.images!
                        .map((e) => Image.network(
                              e.toString(),
                              fit: BoxFit.contain,
                            ))
                        .toList(),
                    options: CarouselOptions(
                        height: 150,
                        autoPlay: false,
                        autoPlayInterval: const Duration(seconds: 1),
                        onPageChanged: (index, reason) {
                          setState(() {
                            cindex = index;
                          });
                        },
                        initialPage: 0,
                        viewportFraction: 1)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: indicator(widget.tak.images!.length, cindex),
              )
            ],
          ));
    });
  }
}
