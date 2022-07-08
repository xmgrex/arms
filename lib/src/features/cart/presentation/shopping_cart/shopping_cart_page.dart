import 'package:arms/src/common_widget/common_widget.dart';

import 'package:arms/src/features/cart/data/cart_repository.dart';
import 'package:arms/src/features/cart/presentation/shopping_cart/empty_cart_screen.dart';
import 'package:arms/src/features/cart/presentation/shopping_cart/shopping_cart_item.dart';
import 'package:arms/src/features/cart/presentation/shopping_cart/shopping_cart_items_builder.dart';
import 'package:arms/src/features/cart/presentation/shopping_cart/shopping_cart_page_controller.dart';
import 'package:arms/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:x_kit/x_kit.dart';

import '../../../../../generated/l10n.dart';
import '../../../checkout/domain/payment_summary.dart';
import '../../../checkout/presentation/checkout_screen_controller.dart';
import '../../../checkout/presentation/checkout_screen_state.dart';
import '../../domain/cart.dart';
import 'components/checkout_card.dart';

class ShoppingCartPage extends ConsumerWidget {
  const ShoppingCartPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItemsListValue = ref.watch(cartItemsListStreamProvider);
    final state = ref.watch(shoppingCartPageControllerProvider);

    ref.listen<AsyncValue>(
      shoppingCartPageControllerProvider,
      (_, state) {
        if (state.hasError) {
          state.showAlertDialogOnError(context);
        }
      },
    );
    return LoadingOverlay(
      loadingWidget: const LoadingWidget(),
      isLoading: state.isLoading,
      child: Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).cart, style: TextStyles.title.bold),
        ),
        body: AsyncValueWidget<List<CartItem>>(
          value: cartItemsListValue,
          data: (data) {
            if (data.isNotEmpty) {
              return Stack(
                children: [
                  ShoppingCartItemsBuilder(
                    items: data,
                    itemBuilder: (_, item, index) {
                      return ShoppingCartItem(
                        item: item,
                      );
                    },
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: CheckoutCard(items: data),
                  ),
                ],
              );
            } else {
              return const EmptyCartScreen();
            }
          },
        ),
      ),
    );
  }
}

class CheckoutButton extends ConsumerWidget {
  const CheckoutButton({
    Key? key,
    required this.items,
  }) : super(key: key);

  final List<CartItem> items;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double totalPrice = 0;
    for (var item in items) {
      totalPrice += (item.total() * item.quantity);
    }
    return ScaleButton(
      height: Sizes.p48,
      label: '${S.of(context).checkout}（${S.of(context).subTotal}:'
          ' ${symbolFormatter(totalPrice.round(), items.first.currency)}）',
      radius: 0.0,
      onPressed: () {
        context.goNamed(AppRoute.checkoutScreen.name, extra: items);
      },
    );
  }
}
