import 'package:arms/src/common_widget/section_title.dart';
import 'package:arms/src/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../generated/l10n.dart';
import 'stores_grid.dart';

class FeaturedStores extends ConsumerStatefulWidget {
  const FeaturedStores({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _FeaturedStoresState();
}

class _FeaturedStoresState extends ConsumerState<FeaturedStores> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: getProportionateScreenWidth(16)),
          child: SectionTitle(
            title: S.of(context).featuredStores,
            press: () {},
          ),
        ),
        const StoresGrid(),
      ],
    );
  }
}
