import 'package:arms/src/features/home/presentation/components/special_offers.dart';
import 'package:arms/src/utils/super_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:x_kit/x_kit.dart';
import 'package:arms/src/common_widget/common_widget.dart';

import '../../../../generated/l10n.dart';
import '../../products/presentation/products_list/products_list.dart';
import '../../products/presentation/products_list/popular_product.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: Sizes.p64,
        title: SearchBar(
          hint: S.of(context).inputKeywords,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(SuperIcons.bell),
            color: Theme.of(context).colorScheme.outline,
          )
        ],
      ),
      body: ListView(
        shrinkWrap: true,
        children: const [
          // DiscountBanner(),
          // gapH16,
          // CategoriesWidget(),
          gapH8,
          SpecialOffers(),
          gapH8,
          PopularProducts(),
          gapH8,
          // FeaturedStores(),
          ProductsList(),
        ],
      ),
    );
  }
}
