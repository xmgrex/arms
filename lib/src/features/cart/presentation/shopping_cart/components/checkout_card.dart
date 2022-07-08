import 'package:arms/src/constants/constants.dart';
import 'package:arms/src/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:x_kit/x_kit.dart';

import '../../../../../../generated/l10n.dart';
import '../../../../../common_widget/common_widget.dart';
import '../../../../../routing/app_router.dart';
import '../../../domain/cart.dart';

class CheckoutCard extends ConsumerWidget {
  const CheckoutCard({
    Key? key,
    required this.items,
  }) : super(key: key);

  final List<CartItem> items;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double totalPrice = 0;
    for (var item in items) {
      totalPrice += (item.total() * item.quantity);
    }
    return TopRoundedContainer(
      color: kSecondaryColor.withOpacity(.1),
      child: SizedBox(
        height: getProportionateScreenHeight(64),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Text.rich(
                TextSpan(
                  text: '${S.of(context).total}:\n',
                  children: [
                    TextSpan(
                      text: symbolFormatter(totalPrice.round(), items.first.currency),
                      style: TextStyles.body.large.bold
                    ),
                  ],
                ),
              ),
              gapW16,
              Expanded(
                child: ScaleButton(
                  height: Sizes.p48,
                  label: S.of(context).checkout,
                  onPressed: () {
                    context.goNamed(AppRoute.checkoutScreen.name, extra: items);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
