import 'package:arms/src/common_widget/common_widget.dart';
import 'package:arms/src/routing/app_router.dart';
import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:x_kit/x_kit.dart';

import '../../../../../../generated/l10n.dart';
import '../../../../../constants/constants.dart';
import '../../../domain/credit_card.dart';

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
          title: Text(S.of(context).addCreditCard, style: TextStyles.link.bold),
          onTap: () {
            context.pushNamed(AppRoute.addCreditCardScreen.name);
          },
          trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
        ),
        const Divider(),
        LiveList(
          separatorBuilder: (context, index) {
            return const Divider(indent: indent, endIndent: indent);
          },
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
