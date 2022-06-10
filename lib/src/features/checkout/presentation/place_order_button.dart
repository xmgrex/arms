import 'package:arms/src/features/checkout/presentation/checkout_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:x_kit/x_kit.dart';

import '../../cart/domain/cart.dart';

class PlaceOrderButton extends ConsumerWidget {
  const PlaceOrderButton({
    Key? key,
    required this.items,
  }) : super(key: key);

  final List<CartItem> items;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Sizes.p16).copyWith(
        top: Sizes.p8,
        bottom: Sizes.p32,
      ),
      child: ScaleButton(
        label: 'Place order',
        onPressed: () {
          ref.read(checkoutScreenControllerProvider.notifier).placeOrder(items);
        },
      ),
    );
  }
}
