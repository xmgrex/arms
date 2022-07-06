import 'package:flutter/material.dart';

Widget divider(BuildContext context,
    {double height = 1, double padding = 0, double thickness = .5, Color? color}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: padding),
    child: Divider(
      thickness: thickness,
      color: color ?? Theme.of(context).colorScheme.outline.withOpacity(.4),
      height: height,
    ),
  );
}
