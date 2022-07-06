import 'package:arms/src/features/checkout/presentation/checkout_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:x_kit/x_kit.dart';
import '../../../address/presentation/choose_address/choose_address_list_tile.dart';
import '../../../address/presentation/choose_address/choose_address_list_view_builder.dart';
import '../../../top_level_providers.dart';
import 'delivery_option_contents.dart';

class DeliveringToWidget extends ConsumerWidget {
  const DeliveringToWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(checkoutScreenControllerProvider);

    return DeliveryOptionContents(
      title: 'Delivering to',
      contents: Text(
        state.deliveryOptions != null
            ? state.deliveryOptions!.address.displayFullAddress()
            : '',
        style: TextStyles.body.small.bold,
      ),
      onTap: () {
        showChooseAddressModalSheet(context);
      },
    );
  }
}

void showChooseAddressModalSheet(BuildContext context) {
  showHalfModalBottomSheet(
    height: MediaQuery.of(context).size.height * .5,
    widget: const Scaffold(
      body: ChooseAddressModalSheetBodyWidget(),
    ),
    context: context,
  );
}

class ChooseAddressModalSheetBodyWidget extends ConsumerWidget {
  const ChooseAddressModalSheetBodyWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appUser = ref.watch(appUserStateProvider);
    final state = ref.watch(checkoutScreenControllerProvider);
    final controller = ref.watch(checkoutScreenControllerProvider.notifier);

    return ChooseAddressListViewBuilder(
      addresses: appUser != null ? appUser.addresses : [],
      itemBuilder: (_, address, index) {
        return ChooseAddressListTile(
          secondary: const SizedBox(),
          address: address,
          defaultAddressId: state.deliveryOptions != null
              ? state.deliveryOptions!.address.id
              : '',
          onChanged: (v) {
            controller.chooseAddress(address);
          },
        );
      },
    );
  }
}
