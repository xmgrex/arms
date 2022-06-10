import 'package:arms/src/features/checkout/domain/delivery_options.dart';
import 'package:arms/src/features/checkout/domain/payment_summary.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CheckoutScreenState {
  const CheckoutScreenState({
    this.asyncValue = const AsyncValue.data(null),
    this.deliveryOptions,
    this.paymentSummary,
  });

  final AsyncValue<void> asyncValue;
  final DeliveryOptions? deliveryOptions;
  final PaymentSummary? paymentSummary;

  CheckoutScreenState copyWith({
    AsyncValue<void>? asyncValue,
    DeliveryOptions? deliveryOptions,
    PaymentSummary? paymentSummary,
  }) {
    return CheckoutScreenState(
      asyncValue: asyncValue ?? this.asyncValue,
      deliveryOptions: deliveryOptions ?? this.deliveryOptions,
      paymentSummary: paymentSummary ?? this.paymentSummary,
    );
  }
}