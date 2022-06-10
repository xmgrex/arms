import 'package:arms/src/constants/types.dart';
import 'package:arms/src/features/products/domain/sku.dart';
import 'package:arms/src/features/products/presentation/product_screen/porduct_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:x_kit/x_kit.dart';

class ProductPrice extends ConsumerWidget {
  const ProductPrice({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(productScreenControllerProvider);
    final isNull = state.selectSKU == null;
    final isDiscount = state.selectSKU?.discount.type != DiscountType.none;
    return isNull
        ? Container()
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: isDiscount
                ? discountPrice(state.selectSKU!)
                : price(
                    state.selectSKU!,
                  ),
          );
  }

  Widget price(SKU sku) {
    return Text.rich(
      TextSpan(
        text: 'TAX: ',
        children: <TextSpan>[
          TextSpan(
            text: sku.displayTotal(),
            style: TextStyles.title.large,
          ),
        ],
      ),
    );
  }

  Widget discountPrice(SKU sku) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            text: 'COST: ',
            children: <TextSpan>[
              TextSpan(
                text: sku.displayPrice(), //税抜き,割引前
                style: TextStyles.title.lineThrough,
              ),
              TextSpan(
                text: sku.displaySubTotal(), //税抜き,割引後
                style: TextStyles.title.large.bold.copyWith(color: Colors.red),
              ),
            ],
          ),
        ),
        Text.rich(
          TextSpan(
            text: 'TAX: ',
            children: <TextSpan>[
              TextSpan(
                text: sku.displayTotal(),
                style: TextStyles.title.lineThrough,
              ),
              TextSpan(
                text: sku.displayDiscountTotal(),
                style: TextStyles.title.large.bold.copyWith(color: Colors.red),
              ),
            ],
          ),
        ),
        sku.discount.type == DiscountType.absolute
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
              ),
      ],
    );
  }
}
