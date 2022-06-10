import 'package:arms/src/constants/constants.dart';
import 'package:arms/src/features/products/domain/product_option.dart';
import 'package:arms/src/features/products/domain/product.dart';
import 'package:arms/src/features/products/presentation/product_screen/porduct_screen_controller.dart';
import 'package:arms/src/features/products/presentation/product_screen/product_option_values.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:x_kit/x_kit.dart';
import 'package:arms/src/common_widget/common_widget.dart';


class ProductOptions extends ConsumerWidget {
  const ProductOptions({
    Key? key,
    required this.options,
  }) : super(key: key);

  final List<ProductOption> options;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(productScreenControllerProvider.notifier);
    ref.watch(productScreenControllerProvider);

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: options.length,
      itemBuilder: (context, int i) {
        final optionValue = notifier.searchSelectOptionValue(options[i]);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            divider(context),
            ListTile(
              contentPadding: EdgeInsets.zero,
              onTap: () async {
                await showSelectOptionValueModalSheet(context, options[i]);
              },
              title: Text(options[i].name, style: TextStyles.title.bold),
              subtitle: Text(
                optionValue.name,
                style: TextStyles.title,
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: Sizes.p12),
            ),
          ],
        );
      },
    );
  }
}
