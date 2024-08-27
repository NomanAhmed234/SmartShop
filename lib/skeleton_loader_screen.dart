import 'package:flutter/material.dart';

class SkeletonLoader extends StatelessWidget {
  final double height;
  final double width;

  const SkeletonLoader({
    Key? key,
    this.height = 20,
    this.width = 50,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
