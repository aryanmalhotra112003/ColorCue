import 'package:flutter/material.dart';

class SharedHeroTitle extends StatelessWidget {
  final String text;
  final DateTime id;
  final Color color;
  final double size;

  const SharedHeroTitle({
    super.key,
    required this.text,
    required this.id,
    required this.color,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: '$text+$id',
      child: Material(
        color: Colors.transparent,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Text(
            text,
            style: TextStyle(
              fontSize: size,
              color: color,
            ),
            overflow: TextOverflow.visible,
            softWrap: false,
          ),
        ),
      ),
    );
  }
}
