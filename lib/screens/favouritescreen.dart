import 'package:ecommerce_app/models/Product.dart';
import 'package:ecommerce_app/providers/dummy_data.dart';
import 'package:ecommerce_app/screens/detailscreen.dart';

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
    List<ProductModel> favProducts =
        Provider.of<Products>(context).getFavourites;

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
                      return ChangeNotifierProvider.value(
                        value: favProducts[index],
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, DetailScreen.routName,
                                arguments: favProducts[index]);
                          },
                          child: Container(
                              margin: const EdgeInsets.only(
                                  left: 4, right: 4, top: 2),
                              constraints: const BoxConstraints.expand(
                                height: 150,
                              ),
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12))),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        favProducts[index].off.toString() == '0'
                                            ? Container()
                                            : Container(
                                                constraints:
                                                    const BoxConstraints.expand(
                                                  width: 40,
                                                  height: 30,
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
                                        Consumer<ProductModel>(builder:
                                            (context, productModel, child) {
                                          return GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                // productModel.doFavourite();
                                              });
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8.0),
                                              child: favProducts[index]
                                                      .isFavourite!
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
                                          );
                                        })
                                      ],
                                    ),
                                    Container(
                                        // margin: const EdgeInsets.only(top: 25, bottom: 25),
                                        padding: const EdgeInsets.all(2.0),
                                        child: Stack(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(3),
                                              decoration: const BoxDecoration(),
                                              width: double.infinity,
                                              height: 98,
                                              child: Image.network(
                                                favProducts[index].imageUrl![0],
                                                height: 50,
                                              ),
                                            ),
                                          ],
                                        )),
                                    const SizedBox(
                                      height: 10,
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
                                      height: 10,
                                    ),
                                    Text(
                                      '\$ ${favProducts[index].price}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color:
                                              Color.fromARGB(255, 3, 67, 121)),
                                    ),
                                  ],
                                ),
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
