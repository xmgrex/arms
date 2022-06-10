import 'package:arms/src/features/payment/data/payment_repository.dart';
import 'package:arms/src/features/payment/domain/credit_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PaymentMethodsController extends StateNotifier<AsyncValue> {
  PaymentMethodsController(this.paymentRepository) : super(const AsyncValue.data(null),);

  final PaymentRepository paymentRepository;

  Future<void> setDefaultCreditCard(CreditCard creditCard) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await paymentRepository.setDefaultCreditCard(creditCard);
    });
  }

  Future<void> deleteCreditCard(CreditCard creditCard, bool isDefault) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await paymentRepository.deleteCreditCard(creditCard, isDefault);
    });
  }

}

final paymentMethodsControllerProvider = StateNotifierProvider.autoDispose<
    PaymentMethodsController, AsyncValue<void>>((ref) {
  final paymentRepository = ref.watch(paymentRepositoryProvider);
  return PaymentMethodsController(paymentRepository);
});