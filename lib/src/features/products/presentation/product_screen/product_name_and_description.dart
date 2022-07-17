import 'package:arms/src/features/products/domain/product.dart';
import 'package:arms/src/features/products/presentation/product_screen/product_screen_controller.dart';
import 'package:arms/src/features/products/presentation/product_screen/product_price.dart';
import 'package:arms/src/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:x_kit/x_kit.dart';

class ProductNameAndDescription extends ConsumerWidget {
  const ProductNameAndDescription({
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectSKU = ref.watch(productScreenControllerProvider.select((state) => state.selectSKU));
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              selectSKU == null ? '' : selectSKU.name,
              style: TextStyles.title.bold,
            ),
            gapH8,
            SizedBox(
              height: Sizes.p48,
              child: Text(
                selectSKU == null ? '' : selectSKU.description,
                style: TextStyles.label,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
