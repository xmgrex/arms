import 'package:arms/src/common_widget/common_widget.dart';
import 'package:arms/src/features/products/data/product_repository.dart';
import 'package:arms/src/features/products/domain/product.dart';
import 'package:arms/src/features/products/presentation/products_list/product_card.dart';
import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:x_kit/x_kit.dart';

import '../../../../common_widget/section_title.dart';
import '../../../../utils/size_config.dart';
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
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
          child: SectionTitle(title: "Popular Products", press: () {}),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        SizedBox(
          height: 193,
          child: AsyncValueWidget<List<Product>>(
            value: productListValue,
            data: (products) {
              return products.isEmpty
                  ? const Center(
                      child: Text('No products found'),
                    )
                  : LiveList(
                    scrollDirection: Axis.horizontal,
                    itemCount: products.length,
                    itemBuilder: (c, index, animation) {
                      return ProductCard(product: products[index]);
                    },
                  );
            },
            loading: () => const LoadingShimmerWidget(),
          ),
        ),
      ],
    );
  }
}
