import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';

class DeliveryHourGridItem extends StatelessWidget {
  const DeliveryHourGridItem({
    Key? key,
    this.onPressed,
    this.textStyle,
    required this.label,
    required this.color,
    required this.borderColor,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final Color color;
  final Color borderColor;
  final String label;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return ScaleTap(
      enableFeedback: false,
      onPressed: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color: borderColor,
          ),
        ),
        child: Center(
          child: Text(label, style: textStyle),
        ),
      ),
    );
  }
}
