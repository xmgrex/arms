import 'package:arms/src/constants/constants.dart';
import 'package:arms/src/features/address/domain/shipping_address.dart';
import 'package:arms/src/features/authentication/data/auth_repository.dart';
import 'package:arms/src/features/authentication/domain/app_user.dart';
import 'package:arms/src/features/cart/data/cart_repository.dart';
import 'package:arms/src/features/checkout/data/checkout_repository.dart';
import 'package:arms/src/features/checkout/domain/delivery_options.dart';
import 'package:arms/src/features/checkout/domain/order.dart';
import 'package:arms/src/features/checkout/domain/payment_summary.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:x_kit/x_kit.dart';

import '../../cart/domain/cart.dart';
import '../../cart/presentation/shopping_cart/shopping_cart_page.dart';
import '../../top_level_providers.dart';
import '../domain/scheduled_delivery_date.dart';
import 'checkout_screen_state.dart';

final checkoutScreenControllerProvider = StateNotifierProvider.autoDispose<
    CheckoutScreenController, CheckoutScreenState>((ref) {
  final cartItems = ref.watch(cartItemsListStreamProvider).value!;
  return CheckoutScreenController(cartItems, ref.read);
});

class CheckoutScreenController extends StateNotifier<CheckoutScreenState> {
  CheckoutScreenController(List<CartItem> cartItems, this._read)
      : super(CheckoutScreenState(
          paymentSummary: PaymentSummary.init(cartItems),
        )) {
    initState();
  }

  final Reader _read;

  Future<void> initState() async {
    DeliveryOptions? options;
    PaymentSummary? paymentSummary;
    state = state.copyWith(asyncValue: const AsyncValue.loading());
    final appUser = await _read(authRepositoryProvider).fetchAppUser();
    final result = await AsyncValue.guard(() async {
      final defaultAddressId =
          await _read(checkoutRepositoryProvider).getDefaultAddressId();
      final i = appUser.addresses.indexWhere((e) => e.id == defaultAddressId);
      options = DeliveryOptions(
        address: appUser.addresses[i],
        scheduledDeliveryDate: ScheduledDeliveryDate.init(),
      );
      paymentSummary = state.paymentSummary!.copyWith(
        creditCard: appUser.defaultCard,
      );
    });
    state = state.copyWith(
      asyncValue: result,
      deliveryOptions: options,
      paymentSummary: paymentSummary,
    );
  }

  void chooseAddress(ShippingAddress address) {
    state = state.copyWith(
      deliveryOptions: state.deliveryOptions!.copyWith(
        address: address,
      ),
    );
  }

  void selectDeliveryInstruction(DeliveryInstruction? value) {
    final address = state.deliveryOptions!.address;
    state = state.copyWith(
      deliveryOptions: state.deliveryOptions!.copyWith(
        address: address.copyWith(
          instruction: displayDeliveryInstruction(value!),
        ),
      ),
    );
  }

  void selectDate(DateTime date) {
    final scheduledDeliveryDate = state.deliveryOptions!.scheduledDeliveryDate;
    final now = DateTime.now();
    DeliveryTime? deliveryTime;
    if (date.compareTo(now) <= 0) {
      for (var value in Constants.deliveryTimes) {
        if (value.hour == now.hour + 1) {
          deliveryTime = value;
        }
      }
      state = state.copyWith(
        deliveryOptions: state.deliveryOptions!.copyWith(
          scheduledDeliveryDate: scheduledDeliveryDate.copyWith(
            date: date,
            deliveryTime: deliveryTime,
          ),
        ),
      );
      return;
    }
    state = state.copyWith(
      deliveryOptions: state.deliveryOptions!.copyWith(
        scheduledDeliveryDate: scheduledDeliveryDate.copyWith(date: date),
      ),
    );
  }

  void selectHour(DeliveryTime deliveryTime) {
    final scheduledDeliveryDate = state.deliveryOptions!.scheduledDeliveryDate;
    final date = DateTime(
      scheduledDeliveryDate.date.year,
      scheduledDeliveryDate.date.month,
      scheduledDeliveryDate.date.day,
      deliveryTime.hour,
    );
    state = state.copyWith(
      deliveryOptions: state.deliveryOptions!.copyWith(
        scheduledDeliveryDate: scheduledDeliveryDate.copyWith(
          date: date,
          deliveryTime: deliveryTime,
        ),
      ),
    );
  }

  void setCreditCard(AppUser user) {
    state = state.copyWith(
        paymentSummary: state.paymentSummary!.copyWith(
      creditCard: user.defaultCard,
    ));
  }

  Future<void> placeOrder(List<CartItem> items) async {
    final cartIsNotEmpty = items.isNotEmpty;
    final isPaymentSummary = state.paymentSummary != null;
    final isCreditCard = state.paymentSummary!.creditCard != null;
    final isDeliveryOptions = state.deliveryOptions != null;

    if (cartIsNotEmpty &&
        isPaymentSummary &&
        isCreditCard &&
        isDeliveryOptions) {
      final order = Order.create(
        state.deliveryOptions!,
        state.paymentSummary!,
        items,
      );
      logger.info(order.toString());
    } else {
      logger.shout('error');
    }
  }
}
