import 'package:arms/src/common_widget/common_widget.dart';
import 'package:arms/src/features/products/data/product_repository.dart';
import 'package:arms/src/features/products/domain/product.dart';
import 'package:arms/src/features/products/presentation/products_list/product_card.dart';
import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:x_kit/x_kit.dart';

import 'loading_shimmer_widget.dart';

class ProductsList extends ConsumerStatefulWidget {
  const ProductsList({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _ProductsListState();
}

class _ProductsListState extends ConsumerState<ProductsList> {
  @override
  Widget build(BuildContext context) {
    final productListValue = ref.watch(productsListStreamProvider);
    return SizedBox(
      height: 210.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Products', style: TextStyles.title.bold),
                TextButton(onPressed: () {}, child: const Text('View more')),
              ],
            ),
          ),
          gapH12,
          AsyncValueWidget<List<Product>>(
            value: productListValue,
            data: (products) {
              return products.isEmpty
                  ? const Center(
                      child: Text('No products found'),
                    )
                  : SizedBox(
                      height: 144,
                      child: LiveList(
                        scrollDirection: Axis.horizontal,
                        itemCount: products.length,
                        itemBuilder: (c, index, animation) {
                          return ProductCard(product: products[index]);
                        },
                      ),
                    );
            },
            loading: () => const LoadingShimmerWidget(),
          ),
        ],
      ),
    );
  }
}
