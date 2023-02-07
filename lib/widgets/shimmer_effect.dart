import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';

class ShimmerEffect extends StatelessWidget {
  const ShimmerEffect({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: ListView.builder(itemBuilder: (context, index) {
          return const ListTile(
            title: Text(''),
            subtitle: Text(''),
          );
        }));
  }
}
