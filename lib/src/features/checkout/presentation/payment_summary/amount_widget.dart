import 'package:flutter/material.dart';
import 'package:x_kit/x_kit.dart';

import '../../../../../generated/l10n.dart';
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
          const Divider(),
          gapH8,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.of(context).subTotal,
                style: TextStyles.body.small.grey.bold,
              ),
              Text(
                paymentSummary.displaySubTotalAmount(currency),
                style: TextStyles.body.bold,
              ),
            ],
          ),
          gapH4,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(S.of(context).deliveryFee, style: TextStyles.body.small.grey.bold),
              Text(
                paymentSummary.displayDeliveryFee(currency),
                style: TextStyles.body.bold,
              ),
            ],
          ),
          const Divider(height: Sizes.p32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(S.of(context).orderTotal, style: TextStyles.title.bold),
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
