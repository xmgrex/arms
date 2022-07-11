import 'package:arms/src/features/payment/domain/credit_card.dart';
import 'package:flutter/material.dart';

class CreditCardListTile extends StatelessWidget {
  const CreditCardListTile({
    Key? key,
    required this.creditCard,
    this.trailing,
    this.onTap,
  }) : super(key: key);

  final CreditCard creditCard;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text('${creditCard.brand} ••••${creditCard.last4}'),
      subtitle: Text('${creditCard.expMonth}/${creditCard.expYear}'),
      trailing: trailing,
    );
  }
}
