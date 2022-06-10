import 'package:arms/src/features/payment/data/payment_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddCreditCardController extends StateNotifier<AsyncValue> {
  AddCreditCardController(this.paymentRepository)
      : super(const AsyncValue.data(null));

  final PaymentRepository paymentRepository;

  Future<void> addCreditCard() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return await paymentRepository.addCreditCard();
    });
  }
}

final addCreditCardController =
    StateNotifierProvider.autoDispose<AddCreditCardController, AsyncValue>(
        (ref) {
  final paymentRepository = ref.watch(paymentRepositoryProvider);
  return AddCreditCardController(paymentRepository);
});
