import 'package:flutter/material.dart';
import 'package:x_kit/x_kit.dart';

import '../../generated/l10n.dart';
import '../features/top_level_providers.dart';
import '../utils/size_config.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key? key,
    required this.title,
    required this.press,
  }) : super(key: key);

  final String title;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: TextStyles.title.bold),
        TextButton(
          onPressed: press,
          child: Row(
            children: [
              Text(
                S.of(context).seeMore,
                style: TextStyles.label.bold,
              ),
              const Icon(Icons.arrow_forward_ios, size: 10)
            ],
          ),
        ),
      ],
    );
  }
}
