import 'package:arms/src/routing/app_router.dart';
import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../domain/credit_card.dart';

class CreditCardsListViewBuilder extends StatelessWidget {
  const CreditCardsListViewBuilder({
    Key? key,
    required this.creditCards,
    required this.builder,
  }) : super(key: key);

  final List<CreditCard> creditCards;
  final Function(BuildContext, int, CreditCard) builder;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: const Text('Credit or debit card'),
          trailing: TextButton(
            onPressed: () {
              context.pushNamed(AppRoute.addCreditCardScreen.name);
            },
            child: const Text('Add'),
          ),
        ),
        LiveList(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: creditCards.length,
          itemBuilder: (c, index, _) {
            return builder(c, index, creditCards[index]);
          },
        ),
      ],
    );
  }
}
