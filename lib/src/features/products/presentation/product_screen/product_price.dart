import 'package:arms/src/constants/types.dart';
import 'package:arms/src/features/products/domain/sku.dart';
import 'package:arms/src/features/products/presentation/product_screen/product_screen_controller.dart';
import 'package:arms/src/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:x_kit/x_kit.dart';

import '../../../../../generated/l10n.dart';

class ProductPrice extends ConsumerWidget {
  const ProductPrice({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final state = ref.watch(productScreenControllerProvider);
    final isNull = state.selectSKU == null;
    final isDiscount = state.selectSKU?.discount.type != DiscountType.none;
    return isNull
        ? Container()
        : Padding(
            padding: EdgeInsets.symmetric(
              vertical: getProportionateScreenHeight(8),
              horizontal: getProportionateScreenWidth(16),
            ),
            child: isDiscount
                ? discountPrice(state.selectSKU!, colorScheme, context)
                : price(state.selectSKU!, context),
          );
  }

  Widget price(SKU sku, BuildContext context) {
    return Text.rich(
      TextSpan(
        text: sku.displayTotal(),
        style: TextStyles.title.large.bold,
        children: <TextSpan>[
          TextSpan(
            text: '（${S.of(context).taxInclusive}）',
            style: TextStyles.label.grey,
          ),
        ],
      ),
    );
  }

  Widget discountPrice(SKU sku, ColorScheme colorScheme, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        taxInclusive(sku, colorScheme, context),
        // discountRate(sku),
      ],
    );
  }

  Widget taxExcluded(SKU sku) {
    return Text.rich(
      TextSpan(
        text: sku.displayPrice(), //税抜き,割引前
        style: TextStyles.body.bold.lineThrough,
        children: <TextSpan>[
          TextSpan(
            text: sku.displaySubTotal(), //税抜き,割引後
            style: TextStyles.title.large.bold.copyWith(
              color: Colors.red,
              decoration: TextDecoration.none,
            ),
          ),
        ],
      ),
    );
  }

  Widget taxInclusive(SKU sku, ColorScheme colorScheme, BuildContext context) {
    return Text.rich(
      TextSpan(
        text: sku.displayTotal(),
        style: TextStyles.body.bold.lineThrough,
        children: <TextSpan>[
          TextSpan(
            text: sku.displayDiscountTotal(), //税込,割引後
            style: TextStyles.title.large.bold.copyWith(
              color: colorScheme.tertiaryContainer,
              decoration: TextDecoration.none,
            ),
          ),
          TextSpan(
            text: '  (${S.of(context).taxInclusive})',
            style: TextStyles.label.grey.copyWith(
              decoration: TextDecoration.none,
            ),
          ),
        ],
      ),
    );
  }

  Widget discountRate(SKU sku) {
    return sku.discount.type == DiscountType.absolute
        ? Text.rich(
            TextSpan(
              text: 'OFF: ',
              children: <TextSpan>[
                TextSpan(
                  text: sku.displayDiscountAmount(),
                  style: TextStyles.title.bold.copyWith(color: Colors.red),
                ),
              ],
            ),
          )
        : Text.rich(
            TextSpan(
              text: 'OFF: ',
              children: <TextSpan>[
                TextSpan(
                  text: sku.displayDiscountRate(),
                  style: TextStyles.title.bold.copyWith(color: Colors.red),
                ),
              ],
            ),
          );
  }
}
