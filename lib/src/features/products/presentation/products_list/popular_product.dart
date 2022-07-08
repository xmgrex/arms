import 'package:arms/src/constants/test_products.dart';
import 'package:arms/src/features/products/domain/product.dart';
import 'package:flutter/material.dart';
import 'package:x_kit/x_kit.dart';

import '../../../../../generated/l10n.dart';
import '../../../../common_widget/section_title.dart';
import '../../../../constants/demo_data/black_short_sleeve_shirt.dart';
import '../../../../constants/demo_data/compression_inner_long_sleeves.dart';
import '../../../../constants/demo_data/hybrid_knit_jacket.dart';
import '../../../../utils/size_config.dart';
import 'product_card.dart';

final _p = <Product>[
  kShortSleeveShirts,
  kHybridKnitJacket,
  kCompressionInnerLongSleeves,
];

class PopularProducts extends StatelessWidget {
  const PopularProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
          child: SectionTitle(
            title: S.of(context).popularProducts,
            press: () {},
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(
                _p.length,
                (index) {
                  // logger.info(_p[index].imageUrl);
                  return ProductCard(
                      product:
                          _p[index]); // here by default width and height is 0
                },
              ),
              SizedBox(width: getProportionateScreenWidth(20)),
            ],
          ),
        )
      ],
    );
  }
}
