import 'package:arms/src/features/products/presentation/product_screen/porduct_screen_controller.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:x_kit/x_kit.dart';

import '../../domain/sku.dart';

class ProductImages extends ConsumerWidget {
  const ProductImages({
    Key? key,
    // required this.sku,
  }) : super(key: key);

  // final SKU sku;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(productScreenControllerProvider);

    return Container(
      color: SystemColors.grey0,
      height: 280,
      child: state.selectSKU == null || state.selectSKU!.imageUrls.isEmpty
          ? const Center(child: Text('No Image'))
          : Swiper(
              containerHeight: 280,
              itemCount: state.selectSKU!.imageUrls.length,
              itemBuilder: (_, int i) {
                return ImageFromUrl(
                  imageUrl: state.selectSKU!.imageUrls[i],
                  fit: BoxFit.fitHeight,
                );
              },
              viewportFraction: 1,
              scale: 1,
              pagination: const SwiperPagination(),
            ),
    );
  }
}
