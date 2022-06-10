import 'package:arms/src/features/stores/presentaiton/stroes_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:x_kit/x_kit.dart';

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
          padding: const EdgeInsets.only(left: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Featured stores', style: TextStyles.title.bold),
              TextButton(onPressed: () {}, child: const Text('View more')),
            ],
          ),
        ),
        const StoresGrid(),
      ],
    );
  }
}
