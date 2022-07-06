import 'package:flutter/material.dart';
import 'package:x_kit/x_kit.dart';

class OutlinedBtn extends StatelessWidget {
  const OutlinedBtn({
    Key? key,
    required this.label,
    this.press,
    this.style,
    this.color,
    this.radius,
  }) : super(key: key);

  final String label;
  final VoidCallback? press;
  final TextStyle? style;
  final Color? color;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Sizes.p48,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          primary: color ?? Theme.of(context).colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 60),
          ),
        ),
        onPressed: press,
        child: Text(
          label,
          style: style,
        ),
      ),
    );
  }
}
