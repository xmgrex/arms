import 'package:arms/src/features/products/domain/product.dart';
import 'package:arms/src/features/products/presentation/product_screen/porduct_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:x_kit/x_kit.dart';

class ProductNameAndDescription extends ConsumerWidget {
  const ProductNameAndDescription({
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(productScreenControllerProvider);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            state.selectSKU == null ? '' : state.selectSKU!.name,
            style: TextStyles.headline.bold,
          ),
          gapH16,
          Text(
            state.selectSKU == null ? '' : state.selectSKU!.description,
            style: TextStyles.body.large,
          ),
        ],
      ),
    );
  }
}
