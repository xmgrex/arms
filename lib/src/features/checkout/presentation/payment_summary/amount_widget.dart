import 'package:flutter/material.dart';
import 'package:x_kit/x_kit.dart';

import '../../../../common_widget/common_widget.dart';
import '../../domain/payment_summary.dart';

class AmountWidget extends StatelessWidget {
  const AmountWidget({
    Key? key,
    required this.paymentSummary,
    required this.currency,
  }) : super(key: key);

  final PaymentSummary paymentSummary;
  final String currency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          divider(context),
          gapH8,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('SubTotal', style: TextStyles.body.grey),
              Text(paymentSummary.displaySubTotalAmount(currency)),
            ],
          ),
          gapH4,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Delivery fee', style: TextStyles.body.grey),
              Text(
                paymentSummary.displayDeliveryFee(currency),
              ),
            ],
          ),
          divider(context, height: Sizes.p32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Order total', style: TextStyles.title.bold),
              Text(
                paymentSummary.displayOrderTotalAmount(currency),
                style: TextStyles.title.large.bold,
              ),
            ],
          ),
        ],
      ),
    );
  }
}