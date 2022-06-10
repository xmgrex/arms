import 'package:animate_do/animate_do.dart';
import 'package:arms/src/features/products/data/product_repository.dart';
import 'package:arms/src/features/products/domain/product.dart';
import 'package:arms/src/features/products/presentation/product_screen/porduct_screen_controller.dart';
import 'package:arms/src/features/products/presentation/product_screen/prodcut_options.dart';
import 'package:arms/src/features/products/presentation/product_screen/product_images.dart';
import 'package:arms/src/features/products/presentation/product_screen/product_name_and_description.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:x_kit/x_kit.dart';
import 'package:arms/src/common_widget/common_widget.dart';
import '../../../cart/presentation/add_to_cart/add_to_cart_widget.dart';
import '../../domain/sku.dart';
import 'product_price.dart';

class ProductScreen extends ConsumerStatefulWidget {
  const ProductScreen({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  ConsumerState createState() => _ProductScreenState();
}

class _ProductScreenState extends ConsumerState<ProductScreen> {

  @override
  void initState() {
    final controller = ref.read(productScreenControllerProvider.notifier);
    controller.initialOptionValues(widget.product.options);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final skusListValue = ref.watch(skusListFutureProvider(widget.product.id));
    final isLoading = ref.watch(productScreenControllerProvider
        .select((value) => value.value.isLoading));

    ref.listen<AsyncValue>(
      productScreenControllerProvider.select((state) => state.value),
      (_, state) {
        if (state.hasError) {
          state.showAlertDialogOnError(context);
        }
      },
    );
    return Scaffold(
      appBar: AppBar(leading: backPageButton(context: context)),
      body: LoadingOverlay(
        bgColor: Theme.of(context).colorScheme.outline,
        isLoading: isLoading,
        loadingWidget: const LoadingWidget(),
        child: AsyncValueWidget<List<SKU>>(
          value: skusListValue,
          data: (skusList) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              final controller =
                  ref.read(productScreenControllerProvider.notifier);
              controller.setSKUsList(skusList);
            });
            return FadeIn(
              duration: const Duration(milliseconds: 400),
              child: Stack(
                children: [
                  ListView(
                    shrinkWrap: true,
                    children: [
                      const ProductImages(),
                      const ProductNameAndDescription(),
                      const ProductPrice(),
                      ProductOptions(options: widget.product.options),
                      gapH64,
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: AddToCartWidget(
                      addToCart: (quantity) {
                        final controller =
                            ref.read(productScreenControllerProvider.notifier);
                        return controller.addToCart(quantity, widget.product);
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
