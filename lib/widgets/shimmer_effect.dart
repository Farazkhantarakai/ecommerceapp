import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';

class DoShimming extends StatelessWidget {
  const DoShimming({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: const Color.fromARGB(255, 231, 101, 101),
        highlightColor: const Color.fromARGB(255, 179, 22, 22),
        child: ListView.builder(itemBuilder: (context, index) {
          return const ListTile(
            title: Text(''),
            subtitle: Text(''),
          );
        }));
  }
}
