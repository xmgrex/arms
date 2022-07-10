import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:x_kit/x_kit.dart';
import 'package:arms/src/common_widget/common_widget.dart';

import '../../domain/cart.dart';

class ShoppingCartItemsBuilder extends ConsumerWidget {
  const ShoppingCartItemsBuilder({
    Key? key,
    required this.items,
    required this.itemBuilder,
  }) : super(key: key);

  final List<CartItem> items;
  final Widget Function(BuildContext, CartItem, int) itemBuilder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.separated(
      // physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: Sizes.p16),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return itemBuilder(context, item, index);
      },
      separatorBuilder: (_, index) {
        return const Divider();
      },
    );
  }
}