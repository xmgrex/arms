import 'package:flutter/material.dart';
import 'package:x_kit/x_kit.dart';

class DeliveryOptionContents extends StatelessWidget {
  const DeliveryOptionContents({
    Key? key,
    required this.title,
    this.contents,
    this.onTap,
  }) : super(key: key);

  final String title;
  final Widget? contents;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(vertical: Sizes.p4),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyles.body.grey),
          gapH8,
          contents ?? Container(),
        ],
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: Sizes.p12),
    );
  }
}