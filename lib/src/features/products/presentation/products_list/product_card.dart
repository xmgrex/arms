import 'package:arms/src/features/products/domain/product.dart';
import 'package:arms/src/routing/app_router.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:x_kit/x_kit.dart';

import '../product_screen/porduct_screen_controller.dart';

const imageSize = 100.0;
const height = 100.0;

class ProductCard extends ConsumerWidget {
  const ProductCard(
      {Key? key, required this.product, this.isElevationEnabled = false})
      : super(key: key);

  final Product product;
  final bool isElevationEnabled;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, bottom: 12.0),
      child: GestureDetector(
        onTap: () {
          context.pushNamed(
            AppRoute.productScreen.name,
            extra: product,
          );
        },
        child: isElevationEnabled
            ? Card(
                margin: EdgeInsets.zero,
                child: Container(
                  color: Theme.of(context).colorScheme.surface,
                  width: imageSize,
                  child: _ImageAndText(product: product),
                ),
              )
            : SizedBox(
                width: imageSize,
                child: _ImageAndText(product: product, radius: 8.0)),
      ),
    );
  }
}

class _ImageAndText extends StatelessWidget {
  const _ImageAndText({
    Key? key,
    required this.product,
    this.radius = 0.0,
  }) : super(key: key);

  final Product product;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ImageFromUrl(
          radius: radius,
          imageUrl: product.imageUrl,
          width: imageSize,
          height: imageSize,
        ),
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: Text(
            product.name,
            style: TextStyles.label.large,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
