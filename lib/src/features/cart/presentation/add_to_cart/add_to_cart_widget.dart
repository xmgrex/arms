import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:x_kit/x_kit.dart';


class AddToCartWidget extends StatefulWidget {
  const AddToCartWidget({
    Key? key,
    required this.addToCart,
  }) : super(key: key);

  final Function(int) addToCart;

  @override
  State createState() => _AddToCartWidgetState();
}

class _AddToCartWidgetState extends State<AddToCartWidget> {

  var quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Sizes.p8).copyWith(bottom: Sizes.p32),
      width: double.infinity,
      color: Theme.of(context).colorScheme.surface,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _ItemQuantityButton(
            decrement: () {
              if (quantity > 1) {
                setState(() {
                  quantity -= 1;
                });
                HapticFeedback.mediumImpact();
              }
            },
            increment: () {
              setState(() {
                quantity += 1;
              });
              HapticFeedback.mediumImpact();
            },
            quantityString: '$quantity',
          ),
          gapW4,
          Expanded(
            child: ScaleButton(
              height: Sizes.p48,
              label: 'AddToCart',
              radius: Sizes.p4,
              onPressed: () {
                widget.addToCart(quantity);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ItemQuantityButton extends StatelessWidget {
  const _ItemQuantityButton({
    Key? key,
    required this.decrement,
    required this.increment,
    required this.quantityString,
  }) : super(key: key);

  final VoidCallback decrement;
  final VoidCallback increment;
  final String quantityString;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        borderRadius: BorderRadius.circular(Sizes.p4),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceVariant,
            borderRadius: BorderRadius.circular(Sizes.p4),
          ),
          height: Sizes.p48,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: decrement,
                icon: const Icon(Icons.remove),
              ),
              Text(
                quantityString,
                style: TextStyles.title.bold,
              ),
              IconButton(
                onPressed: increment,
                icon: const Icon(Icons.add),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
