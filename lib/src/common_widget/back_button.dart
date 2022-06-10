import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:x_kit/x_kit.dart';

Widget backPageButton({required BuildContext context, IconData? icon}) {
  return IconButton(
    onPressed: () => context.pop(),
    icon: Icon(icon ?? XIcons.arrowBendUpLeft),
  );
}
