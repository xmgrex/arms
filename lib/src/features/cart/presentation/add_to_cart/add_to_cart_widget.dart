import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:x_kit/x_kit.dart';

final _quantityStateProvider = StateProvider<int>((ref) => 1);

class AddToCartWidget extends ConsumerWidget {
  const AddToCartWidget({
    Key? key,
    required this.addToCart,
  }) : super(key: key);

  final Function(int) addToCart;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quantity = ref.watch(_quantityStateProvider.state).state;

    return Container(
      padding: const EdgeInsets.all(Sizes.p8).copyWith(bottom: Sizes.p32),
      width: double.infinity,
      color: Theme.of(context).colorScheme.surface,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _ItemQuantityButton(
            decrement: () => decrement(ref),
            increment: () => increment(ref),
            quantityString: '$quantity',
          ),
          gapW4,
          Expanded(
            child: ScaleButton(
              height: Sizes.p48,
              label: 'AddToCart',
              radius: Sizes.p4,
              onPressed: () {
                addToCart(quantity);
              },
            ),
          ),
        ],
      ),
    );
  }

  void increment(WidgetRef ref) {
    ref.read(_quantityStateProvider.state).update((state) {
      return state = state += 1;
    });
    HapticFeedback.mediumImpact();
  }

  void decrement(WidgetRef ref) {
    final state = ref.read(_quantityStateProvider.state);
    if (state.state > 1) {
      state.update((state) {
        return state = state -= 1;
      });
      HapticFeedback.mediumImpact();
    }
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
