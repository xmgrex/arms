import 'package:arms/src/constants/constants.dart';
import 'package:arms/src/features/products/domain/color_option.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:x_kit/x_kit.dart';

import '../../../../../../generated/l10n.dart';
import '../../../../../utils/size_config.dart';
import '../product_screen_controller.dart';

class ColorDots extends ConsumerWidget {
  const ColorDots({
    Key? key,
    required this.options,
  }) : super(key: key);

  final List<ColorOption> options;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(productScreenControllerProvider);
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: getProportionateScreenHeight(8),
        horizontal: getProportionateScreenWidth(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${S.of(context).color}: ${state.selectColor!.color}', style: TextStyles.body),
          SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ...List.generate(options.length, (index) {
                    final option = options[index];
                    return ColorDot(
                      valueName: option.color,
                      color: option.colorCode.toColor,
                      isSelected: state.selectColor == option,
                      onTap: () {
                        final notifier =
                            ref.read(productScreenControllerProvider.notifier);
                        notifier.selectColor(option);
                      },
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ColorDot extends StatelessWidget {
  const ColorDot({
    Key? key,
    required this.color,
    required this.valueName,
    this.isSelected = false,
    this.onTap,
  }) : super(key: key);

  final Color color;
  final String valueName;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          AnimatedContainer(
            duration: kThemeAnimationDuration,
            margin: const EdgeInsets.only(right: 2),
            padding: EdgeInsets.all(getProportionateScreenWidth(2)),
            height: getProportionateScreenWidth(44),
            width: getProportionateScreenWidth(44),
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(
                width: isSelected ? 3 : 2,
                color: isSelected
                    ? Theme.of(context).colorScheme.onSurface
                    : Colors.transparent,
              ),
              // shape: BoxShape.circle,
            ),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: color,
                border: Border.all(
                    color: kSecondaryColor.withOpacity(.5), width: .5),
                // shape: BoxShape.circle,
              ),
            ),
          ),
          Text(valueName, style: TextStyles.label.bold),
        ],
      ),
    );
  }
}
