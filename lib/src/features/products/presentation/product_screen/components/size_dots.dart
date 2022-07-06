import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:x_kit/x_kit.dart';

import '../../../../../constants/constants.dart';
import '../../../../../utils/size_config.dart';
import '../../../domain/size_option.dart';
import '../product_screen_controller.dart';

class SizeDots extends ConsumerWidget {
  const SizeDots({
    Key? key,
    required this.options,
  }) : super(key: key);

  final List<SizeOption> options;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(productScreenControllerProvider);
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: getProportionateScreenHeight(8),
        horizontal: getProportionateScreenWidth(16),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Size: ${state.selectSize!.size}', style: TextStyles.body),
            Wrap(
              children: [
                ...List.generate(options.length, (index) {
                  final option = options[index];
                  bool isAvailable = false;
                  for (final sku in state.filteredSKUs) {
                    if (sku.size == option) {
                      if (sku.inventory > 0) {
                        isAvailable = true;
                        break;
                      } else {
                        break;
                      }
                    }
                  }
                  logger.finest(state.selectSize);
                  return SizeDot(
                    size: option.value,
                    isSelected: state.selectSize == option,
                    isAvailable: isAvailable,
                    onTap: () {
                      final notifier =
                          ref.read(productScreenControllerProvider.notifier);
                      notifier.selectSize(option);
                    },
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SizeDot extends StatelessWidget {
  const SizeDot({
    Key? key,
    required this.size,
    this.isSelected = false,
    this.isAvailable = false,
    this.onTap,
  }) : super(key: key);

  final String size;
  final bool isSelected;
  final bool isAvailable;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: isAvailable ? onTap : () {},
      child: AnimatedContainer(
        duration: kThemeAnimationDuration,
        margin: const EdgeInsets.only(right: 4),
        padding: EdgeInsets.all(getProportionateScreenWidth(2)),
        height: getProportionateScreenWidth(44),
        width: getProportionateScreenWidth(44),
        decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(
              width: 3,
              color: colorScheme.onBackground,
              style: isSelected ? BorderStyle.solid : BorderStyle.none,
            )
            // shape: BoxShape.circle,
            ),
        child: AnimatedContainer(
          duration: kThemeAnimationDuration,
          decoration: BoxDecoration(
            color: isAvailable
                ? isSelected
                    ? colorScheme.onBackground
                    : Colors.transparent
                : Colors.transparent,
            border: Border.all(
              width: 1.5,
              color: isAvailable
                  ? colorScheme.onSurface
                  : kSecondaryColor.withOpacity(0.5),
            ),
          ),
          child: Center(
            child: Text(
              size,
              style: isAvailable
                  ? isSelected
                      ? TextStyles.body.bold.copyWith(
                          color: colorScheme.onPrimary,
                        )
                      : TextStyles.body.bold
                  : TextStyles.label.bold.grey.lineThrough,
            ),
          ),
        ),
      ),
    );
  }
}
