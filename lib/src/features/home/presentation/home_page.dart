import 'package:arms/src/features/home/presentation/components/discount_banner.dart';
import 'package:arms/src/features/home/presentation/home_page_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:x_kit/x_kit.dart';
import 'package:arms/src/common_widget/common_widget.dart';

import '../../products/presentation/products_list/products_list.dart';
import '../../stores/presentation/featured_stores.dart';
import 'components/categories_widet.dart';

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
        title: const SearchBar(hint: 'Input keywords',),
      ),
      body: ListView(
        children: const [
          gapH16,
          CategoriesWidget(),
          gapH16,
          DiscountBanner(),
          FeaturedStores(),
          ProductsList(),
          ProductsList(),
          ProductsList(),
          ProductsList(),
          ProductsList(),
        ],
      ),
    );
  }
}
