import 'package:ecommerce_app/providers/dummy_data.dart';
import 'package:ecommerce_app/models/Product.dart';
import 'package:ecommerce_app/models/item.dart';
import 'package:ecommerce_app/widgets/singlegriditem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListItem extends StatefulWidget {
  const ListItem({super.key});

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  @override
  Widget build(BuildContext context) {
    List<ProductModel> pro =
        Provider.of<Products>(context, listen: true).getProducts;

    return LayoutBuilder(builder: (context, BoxConstraints ctx) {
      return GridView.builder(
          itemCount: pro.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: ctx.maxWidth / ctx.maxHeight,
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10),
          itemBuilder: (context, index) {
            return ChangeNotifierProvider<ProductModel>.value(
              value: pro[index],
              child: SingleGridItem(
                singleItem: pro[index],
                ctx: ctx,
              ),
            );
          });
    });
  }
}
