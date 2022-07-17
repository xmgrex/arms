import 'package:arms/src/features/products/presentation/product_screen/product_screen_controller.dart';
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
    final selectSKU = ref.watch(
        productScreenControllerProvider.select((state) => state.selectSKU));
    return Container(
      color: SystemColors.grey0,
      height: 320,
      child: selectSKU == null || selectSKU.imageUrls.isEmpty
          ? const Center(child: Text('No Image'))
          : Card(
              margin: EdgeInsets.zero,
              elevation: .4,
              child: Swiper(
                containerHeight: 280,
                itemCount: selectSKU.imageUrls.length,
                itemBuilder: (_, int i) {
                  return selectSKU.imageUrls[i].contains('http')
                      ? ImageFromUrl(
                          imageUrl: selectSKU.imageUrls[i],
                          fit: BoxFit.fitHeight,
                        )
                      : Image.asset(selectSKU.imageUrls[i], fit: BoxFit.cover);
                },
                viewportFraction: 1,
                scale: 1,
                pagination: const SwiperPagination(),
              ),
            ),
    );
  }
}
