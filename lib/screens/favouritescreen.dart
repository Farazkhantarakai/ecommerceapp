import 'package:ecommerce_app/models/Product.dart';
import 'package:ecommerce_app/providers/auth.dart';
import 'package:ecommerce_app/providers/dummy_data.dart';
import 'package:ecommerce_app/screens/detailscreen.dart';
import 'package:ecommerce_app/widgets/imagebgclipper.dart';
import 'package:ecommerce_app/widgets/singlegriditem.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    final List<ProductModel> favProducts =
        Provider.of<Products>(context, listen: false).getFavourites;
    final auth = Provider.of<Auth>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
          elevation: 1,
          backgroundColor: const Color.fromARGB(255, 218, 218, 218),
          title: Row(
            children: const [
              Text.rich(TextSpan(
                  text: 'Your ',
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                        text: 'Favourites',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold))
                  ])),
              SizedBox(
                width: 10,
              ),
              Icon(
                Icons.favorite,
                color: Color.fromARGB(255, 19, 146, 250),
              )
            ],
          )),
      backgroundColor: const Color.fromARGB(255, 218, 218, 218),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.77,
            decoration: const BoxDecoration(
                // color: Colors.white
                ),
            child: favProducts.isEmpty
                ? const Center(
                    child: Text(
                    'No favourite item selected yet',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ))
                : GridView.builder(
                    itemCount: favProducts.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 3,
                      crossAxisSpacing: 3,
                      childAspectRatio: 0.7,
                    ),
                    itemBuilder: (context, index) {
                      if (kDebugMode) {
                        print(favProducts[index].imageUrl![0]);
                      }

                      return ChangeNotifierProvider.value(
                        value: favProducts[index],
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, DetailScreen.routName,
                                arguments: favProducts[index]);
                          },
                          child: Container(
                              margin: const EdgeInsets.only(
                                left: 4,
                                right: 4,
                                top: 2,
                              ),
                              padding: const EdgeInsets.all(2.0),
                              constraints: const BoxConstraints.expand(),
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12))),
                              child: Column(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Row(
                                      children: [
                                        favProducts[index].off.toString() == '0'
                                            ? Container()
                                            : Container(
                                                constraints:
                                                    const BoxConstraints.expand(
                                                  width: 0.12,
                                                  height: 0.08,
                                                ),
                                                decoration: const BoxDecoration(
                                                    color: Color.fromARGB(
                                                        255, 147, 182, 243),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                                child: Center(
                                                    child: Text(
                                                  '${favProducts[index].off}%',
                                                  style: const TextStyle(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                              ),
                                        const Spacer(),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              favProducts[index]
                                                  .toggleFavourite(
                                                      favProducts[index].id,
                                                      auth.token,
                                                      auth.userId);
                                            });
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            child:
                                                favProducts[index].isFavourite!
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
                                                    newColor: getColor(
                                                        favProducts[index]
                                                            .colors![0]),
                                                    radius1: 65,
                                                    radius2: 55),
                                              ),
                                            ),
                                            Container(
                                              padding:
                                                  const EdgeInsets.all(0.03),
                                              decoration: const BoxDecoration(),
                                              width: double.infinity,
                                              height: 100,
                                              child: Center(
                                                child: Image.network(
                                                  favProducts[index]
                                                      .imageUrl![0],
                                                  height: 50,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )),
                                  ),
                                  const SizedBox(
                                    height: 0.02,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5, right: 5),
                                    child: Text(
                                      '${favProducts[index].title}',
                                      softWrap: false,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 0.02,
                                  ),
                                  Text(
                                    '\$ ${favProducts[index].price}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Color.fromARGB(255, 3, 67, 121)),
                                  ),
                                ],
                              )),
                        ),
                      );
                    }),
          )
        ],
      ),
    );
  }
}
