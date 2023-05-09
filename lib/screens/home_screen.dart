import 'package:ecommerce_app/providers/dummy_data.dart';
import 'package:ecommerce_app/widgets/appdrawer.dart';
import 'package:ecommerce_app/widgets/backpack.dart';
import 'package:ecommerce_app/widgets/listitem.dart';
import 'package:ecommerce_app/widgets/sneakers.dart';
import 'package:ecommerce_app/widgets/watch.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const routName = './HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedItem = "Sort By";
  var scaffold = GlobalKey<ScaffoldState>(); //keys are used to distinct widgets
  bool isLoading = false;
  bool isFirst = false;
  bool _isDataFetched = false;
  bool isSearching = false;

  Future callOnce() {
    return Provider.of<Products>(context, listen: false)
        .fetchAndSet()
        .then((_) {
      setState(() {
        isLoading = false;
        _isDataFetched = true;
        if (kDebugMode) {
          print(_isDataFetched);
        }
      });
    });
  }

  @override
  void initState() {
    if (_isDataFetched) {
      return;
    }

    setState(() {
      isLoading = true;
    });
    Future.delayed(Duration.zero).then((_) {
      callOnce();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var prod = Provider.of<Products>(context);
    var mdq = MediaQuery.of(context);

    final searchBar = AppBar(
      backgroundColor: const Color.fromARGB(255, 235, 234, 234),
      elevation: 0,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        onPressed: () {
          setState(() {
            isSearching = false;
          });
        },
      ),
      centerTitle: true,
      title: TextField(
        decoration: const InputDecoration(
            hintText: "Search...",
            hintStyle: TextStyle(color: Colors.black),
            border: InputBorder.none),
        style: const TextStyle(color: Colors.black),
        onChanged: (value) {
          setState(() {
            Provider.of<Products>(context, listen: false)
                .setSearchingValue(value);
          });
        },
      ),
    );

    final appbar = AppBar(
        backgroundColor: const Color.fromARGB(255, 235, 234, 234),
        elevation: 0,
        leading: Container(
          decoration: const BoxDecoration(),
          child: Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              InkWell(
                onTap: () {
                  scaffold.currentState!.openDrawer();
                },
                child: Image.asset(
                  'assets/icons/dots.png',
                  width: 20,
                  height: 20,
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  isSearching = true;
                });
              },
              icon: const Icon(
                Icons.search,
                color: Colors.black,
              ))
        ],
        centerTitle: true,
        title: const Text.rich(TextSpan(
            text: 'E',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            children: [
              TextSpan(text: 'X', style: TextStyle(color: Colors.blue))
            ])));

    return SafeArea(
        child: Scaffold(
            key: scaffold,
            backgroundColor: const Color.fromARGB(255, 235, 234, 234),
            drawer: const AppDrawer(),
            body: isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  )
                : SingleChildScrollView(
                    child: Padding(
                        padding: const EdgeInsets.only(left: 13, right: 13),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 2,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Our Product',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                DropdownButton(
                                    hint: const Text(
                                      'Sort By',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey),
                                    ),
                                    value: _selectedItem,
                                    // dropdownColor: Colors.grey,
                                    items: ['Sort By', 'title', 'price']
                                        .map((String e) {
                                      return DropdownMenuItem<String>(
                                          value: e,
                                          child: Text(
                                            e.toString(),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ));
                                    }).toList(),
                                    onChanged: (String? value) {
                                      setState(() {
                                        _selectedItem = value!;
                                        prod.setSortingItem(_selectedItem);
                                        // if (kDebugMode) {
                                        //   print(_selectedItem);
                                        // }
                                      });
                                    }),
                              ],
                            ),
                            //this row will have items of sneaker watch and backpack
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                      onTap: () {
                                        prod.selectProduct('sneaker');
                                      },
                                      child: const Sneakers()),
                                  InkWell(
                                      onTap: () {
                                        prod.selectProduct('watch');
                                      },
                                      child: const Watch()),
                                  InkWell(
                                      onTap: () {
                                        prod.selectProduct('backpack');
                                      },
                                      child: const BackPack()),
                                ]),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                                constraints: BoxConstraints.expand(
                                    width: double.infinity,
                                    height: (mdq.size.height -
                                            appbar.preferredSize.height -
                                            mdq.padding.top) *
                                        0.7),
                                child: const ListItem())
                          ],
                        )),
                  ),
            appBar: !isSearching ? appbar : searchBar));
  }
}
