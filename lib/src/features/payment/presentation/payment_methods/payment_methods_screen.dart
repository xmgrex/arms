import 'package:arms/src/common_widget/common_widget.dart';
import 'package:arms/src/features/payment/presentation/payment_methods/payment_methods_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:x_kit/x_kit.dart';

import '../../../../../generated/l10n.dart';
import 'components/credit_card_list.dart';

class PaymentMethodsScreen extends ConsumerWidget {
  const PaymentMethodsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue>(paymentMethodsControllerProvider, (_, state) {
      if (state.hasError) {
        state.showAlertDialogOnError(context);
        logger.warning(state.error.toString());
      }
    });
    final state = ref.watch(paymentMethodsControllerProvider);
    return LoadingOverlay(
      loadingWidget: const LoadingWidget(),
      isLoading: state.isLoading,
      child: Scaffold(
        appBar: AppBar(
          leading: backPageButton(context: context),
          title: Text(
            S.of(context).paymentMethods,
            style: TextStyles.title.bold,
          ),
          // actions: [
          //   IconButton(
          //     onPressed: () {
          //       context.pushNamed(AppRoute.addCreditCardScreen.name);
          //     },
          //     icon: const Icon(Icons.add),
          //   ),
          // ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const CreditCardList(),
            ],
          ),
        ),
      ),
    );
  }
}
