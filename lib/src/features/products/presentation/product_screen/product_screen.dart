import 'package:animate_do/animate_do.dart';
import 'package:arms/src/constants/constants.dart';
import 'package:arms/src/features/products/domain/product.dart';
import 'package:arms/src/features/products/presentation/product_screen/product_screen_controller.dart';
import 'package:arms/src/features/products/presentation/product_screen/prodcut_options.dart';
import 'package:arms/src/features/products/presentation/product_screen/product_images.dart';
import 'package:arms/src/features/products/presentation/product_screen/product_name_and_description.dart';
import 'package:arms/src/features/products/presentation/product_screen/components/select_supplier_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:x_kit/x_kit.dart';
import 'package:arms/src/common_widget/common_widget.dart';
import '../../../cart/presentation/add_to_cart/add_to_cart_widget.dart';
import 'product_price.dart';

class ProductScreen extends ConsumerWidget {
  const ProductScreen({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Future(() => ref
    //     .watch(productScreenControllerProvider.notifier)
    //     .fetchSuppliersListAndSKUsList(product.id));
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name, style: TextStyles.title.bold),
        leading: backPageButton(context: context),
      ),
      body: Consumer(
        builder: (context, ref, _) {
          final init = ref.watch(fetchSuppliersAndSKUsProvider(product.id));
          return AsyncValueWidget(value: init, data: (_) {
            return FadeIn(
                  duration: kThemeAnimationDuration,
                  child: _Body(product: product),
                );
          });
        },
      ),
    );
  }
}

class _Body extends ConsumerWidget {
  const _Body({Key? key, required this.product}) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      shrinkWrap: true,
      children: [
        const ProductNameAndDescription(),
        const ProductImages(),
        gapH16,
        ProductOptions(product: product),
        const ProductPrice(),
        _addToCartWidget(),
        gapH8,
        const Divider(thickness: 4, height: 16),
        const SelectSupplierWidget(),
        gapH64,
      ],
    );
  }

  Widget _addToCartWidget() {
    return Consumer(builder: (c, ref, _) {
      final selectSKU = ref.watch(
          productScreenControllerProvider.select((state) => state.selectSKU));
      return selectSKU != null && selectSKU.inventory > 0
          ? AddToCartWidget(
              addToCart: (quantity) {
                final controller =
                    ref.read(productScreenControllerProvider.notifier);
                return controller.addToCart(quantity, product);
              },
            )
          : gap0;
    });
  }
}
