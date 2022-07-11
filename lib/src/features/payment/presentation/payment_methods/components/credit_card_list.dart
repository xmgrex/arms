import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:arms/src/features/payment/presentation/payment_methods/empty_wallet_screen.dart';
import 'package:arms/src/features/payment/presentation/payment_methods/payment_methods_controller.dart';
import 'package:arms/src/features/top_level_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:x_kit/x_kit.dart';

import '../../../../../../generated/l10n.dart';
import '../../../../../common_widget/common_widget.dart';
import '../../../data/payment_repository.dart';
import '../../../domain/credit_card.dart';
import 'credit_card_list_tile.dart';
import 'credit_cards_list_view_builder.dart';

class CreditCardList extends ConsumerWidget {
  const CreditCardList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appUser = ref.watch(appUserStateProvider);
    final nullCheckOnAppUser = appUser != null && appUser.defaultCard != null;
    return AsyncValueWidget<List<CreditCard>>(
      value: ref.watch(creditCardsStreamProvider),
      data: (data) {
        return data.isEmpty
          ? const EmptyWalletScreen()
          : CreditCardsListViewBuilder(
          creditCards: data,
          builder: (_, index, creditCard) {
            final isDefault = nullCheckOnAppUser && appUser.defaultCard!.id == creditCard.id;
            return CreditCardListTile(
              onTap: () async {
                final controller =  ref.read(paymentMethodsControllerProvider.notifier);
                final result = await showModalActionSheet(
                  context: context,
                  actions: [
                    SheetAction(label: S.of(context).setDefault, key: 'default'),
                    SheetAction(
                      key: 'delete',
                      label: S.of(context).delete,
                      isDestructiveAction: true,
                    ),
                  ],
                );
                if (result == 'default' && !isDefault) {
                  await controller.setDefaultCreditCard(creditCard);
                } else if (result == 'delete') {
                  await controller.deleteCreditCard(creditCard, isDefault);
                }
              },
              creditCard: creditCard,
              trailing: nullCheckOnAppUser
                  ? isDefault
                      ? Text(S.of(context).defaultStr, style: TextStyles.body.bold.success)
                      : null
                  : null,
            );
          },
        );
      },
    );
  }
}
