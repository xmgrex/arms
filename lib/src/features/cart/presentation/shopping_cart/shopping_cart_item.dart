import 'package:arms/src/features/cart/domain/cart.dart';
import 'package:arms/src/features/cart/presentation/shopping_cart/shopping_cart_page_controller.dart';
import 'package:arms/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:x_kit/x_kit.dart';


class ShoppingCartItem extends ConsumerWidget {
  const ShoppingCartItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  final CartItem item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: ImageFromUrl(imageUrl: item.imageUrls.first),
          title: Text(
            item.name,
            style: TextStyles.body.large.bold,
          ),
          subtitle: Text(item.description, maxLines: 2),
          trailing: Text(
            item.displayDiscountTotal(),
            maxLines: 2,
            style: TextStyles.title.large,
          ),
        ),
        QuantityButtonWidget(item: item),
      ],
    );
  }
}

class QuantityButtonWidget extends ConsumerStatefulWidget {
  const QuantityButtonWidget({
    Key? key,
    required this.item,
  }) : super(key: key);

  final CartItem item;

  @override
  ConsumerState createState() => _QuantityButtonWidgetState();
}

class _QuantityButtonWidgetState extends ConsumerState<QuantityButtonWidget> {
  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(shoppingCartPageControllerProvider.notifier);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 140.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: IconButton(
                    iconSize: Sizes.p24,
                    onPressed: () => controller.decrement(widget.item),
                    icon: const Icon(Icons.remove_circle_outline),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      widget.item.quantity.toString(),
                      style: TextStyles.body.large.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: IconButton(
                    iconSize: Sizes.p24,
                    onPressed: () => controller.increment(widget.item),
                    icon: const Icon(Icons.add_circle_outline),
                  ),
                ),
              ],
            ),
          ),
          ScaleButtonWithIcon(
            onPressed: () => controller.deleteFromCart(widget.item),
            buttonColor: Theme.of(context).colorScheme.onSurface,
            width: 110,
            height: Sizes.p32,
            iconSize: Sizes.p20,
            icon: XIcons.delete,
            iconColor: Theme.of(context).colorScheme.background,
            textStyle: TextStyle(
              color: Theme.of(context).colorScheme.background,
            ),
            label: 'Delete',
          ),
        ],
      ),
    );
  }
}
