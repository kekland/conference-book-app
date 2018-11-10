import 'package:flutter/material.dart';

class TagChip extends StatelessWidget {
  final Widget label;
  final Color backgroundColor;

  const TagChip({Key key, this.label, this.backgroundColor}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        decoration: ShapeDecoration(
          shape: StadiumBorder(),
          color: backgroundColor
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: label,
        ),
      ),
    );
  }
}