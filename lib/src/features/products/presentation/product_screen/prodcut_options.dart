import 'package:arms/src/features/products/presentation/product_screen/components/color_dots.dart';
import 'package:arms/src/features/products/presentation/product_screen/components/size_dots.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../constants/constants.dart';
import '../../domain/product.dart';

class ProductOptions extends ConsumerWidget {
  const ProductOptions({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        colorDots(),
        sizeDots(),
      ],
    );
  }

  Widget colorDots() {
    if (product.colors != null && product.colors!.isNotEmpty) {
      return ColorDots(options: product.colors!);
    } else {
      return gap0;
    }
  }

  Widget sizeDots() {
    if (product.sizes != null && product.sizes!.isNotEmpty) {
      return SizeDots(options: product.sizes!);
    } else {
      return gap0;
    }
  }
}
