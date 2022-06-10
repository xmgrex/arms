import 'package:arms/src/common_widget/common_widget.dart';
import 'package:arms/src/features/checkout/presentation/payment_summary/select_credit_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:x_kit/x_kit.dart';

import '../../../cart/domain/cart.dart';
import '../../domain/payment_summary.dart';
import '../checkout_screen_controller.dart';
import 'amount_widget.dart';

class PaymentSummaryWidget extends ConsumerWidget {
  const PaymentSummaryWidget({
    Key? key,
    required this.items,
  }) : super(key: key);

  final List<CartItem> items;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(checkoutScreenControllerProvider);
    final paymentSummary = state.paymentSummary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text('Payment summary', style: TextStyles.title.large.bold),
        ),
        SelectCreditCardWidget(paymentSummary: paymentSummary!),
        AmountWidget(
          paymentSummary: paymentSummary,
          currency: items.first.currency,
        ),
      ],
    );
  }
}
