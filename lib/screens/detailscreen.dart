import 'package:ecommerce_app/providers/dummy_data.dart';
import 'package:ecommerce_app/models/Product.dart';
import 'package:ecommerce_app/widgets/carousolcontainer.dart';
import 'package:ecommerce_app/widgets/productdetails.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  static const routName = 'detailpage';

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late AppBar appBar;
  @override
  Widget build(BuildContext context) {
    var tData = ModalRoute.of(context)!.settings.arguments as ProductModel;
    var cData = Provider.of<Products>(context, listen: false).getProducts;
    print(cData);
    //singlewhere will give you that single item
    var tak = cData.singleWhere((element) => element.id == tData.id);
    //this will calculate sizes dynamically
    var mdq = MediaQuery.of(context);
    return Scaffold(
      appBar: detailScreenBar(tak),
      body: SafeArea(
        child: Column(
          children: [
            //caraousol container
            Container(
              width: double.infinity,
              height: (mdq.size.height -
                      appBar.preferredSize.height -
                      mdq.viewPadding.top) *
                  0.4,
              decoration: const BoxDecoration(),
              child: CarousolContainer(tak: tak),
            ),
            // product detail container
            Container(
              width: double.infinity,
              height: mdq.size.height * 0.5,
              decoration: const BoxDecoration(),
              child: ProductDetail(
                tak: tak,
              ),
            ),
            //positioned
            //CheckOutDart(tak: tak),
          ],
        ),
      ),
    );
  }

  //  Item tak
  detailScreenBar(ProductModel tak) {
    appBar = AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
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
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  )),
            ],
          ),
        ),
        actions: [
          Consumer(builder: (context, data, child) {
            return IconButton(
                onPressed: () {
                  setState(() {
                    tak.doFavourite();
                  });
                },
                icon: tak.isFavourite!
                    ? const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      )
                    : const Icon(
                        Icons.favorite,
                        color: Colors.grey,
                      ));
          })
        ],
        centerTitle: true,
        title: const Text.rich(TextSpan(
            text: 'E',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            children: [
              TextSpan(text: 'X', style: TextStyle(color: Colors.blue))
            ])));
    return appBar;
  }
}
