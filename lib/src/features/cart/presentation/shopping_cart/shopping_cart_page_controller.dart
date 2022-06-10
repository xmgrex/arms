import 'package:arms/src/features/cart/data/cart_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/cart.dart';

final shoppingCartPageControllerProvider =
    StateNotifierProvider.autoDispose<ShoppingCartPageController, AsyncValue>(
        (ref) {
  final cartRepository = ref.read(cartRepositoryProvider);
  return ShoppingCartPageController(cartRepository: cartRepository);
});

class ShoppingCartPageController extends StateNotifier<AsyncValue> {
  ShoppingCartPageController({required this.cartRepository})
      : super(const AsyncValue.data(null));

  final CartRepository cartRepository;

  Future<void> increment(CartItem item) async {
    state = const AsyncValue.loading();
    final quantity = item.quantity;
    final afterData = item.copyWith(quantity: quantity + 1);
    state = await AsyncValue.guard(() async {
      return cartRepository.updateCart(afterData);
    });
  }

  Future<void> decrement(CartItem item) async {
    final quantity = item.quantity;
    if (quantity > 1) {
      state = const AsyncValue.loading();
      final afterData = item.copyWith(quantity: quantity - 1);
      state = await AsyncValue.guard(() {
        return cartRepository.updateCart(afterData);
      });
    }
  }

  Future<void> deleteFromCart(CartItem item) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => cartRepository.deleteFromCart(item));
  }
}
