import 'package:arms/src/common_widget/common_widget.dart';
import 'package:arms/src/features/address/presentation/choose_address/choose_address_list_tile.dart';
import 'package:arms/src/features/address/presentation/choose_address/choose_address_list_view_builder.dart';
import 'package:arms/src/features/top_level_providers.dart';
import 'package:arms/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:x_kit/x_kit.dart';

import '../../../../../generated/l10n.dart';
import '../../../../common_widget/back_button.dart';
import 'choose_address_controller.dart';

class ChooseAddressScreen extends ConsumerWidget {
  const ChooseAddressScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appUser = ref.watch(appUserStateProvider);
    final state = ref.watch(chooseAddressControllerProvider);
    final controller = ref.watch(chooseAddressControllerProvider.notifier);
    final s = S.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: backPageButton(context: context),
        title: Text(s.chooseAddress, style: TextStyles.title.bold),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              onTap: () => context.pushNamed(AppRoute.addAddressScreen.name),
              title: Text(s.addNewAddress),
              trailing: const Icon(Icons.arrow_forward_ios, size: Sizes.p16),
            ),
            ChooseAddressListViewBuilder(
              addresses: appUser != null ? appUser.addresses : [],
              itemBuilder: (_, address, index) {
                return ChooseAddressListTile(
                  address: address,
                  defaultAddressId: state.defaultAddressId,
                  onChanged: (v) async {
                    logger.info(v);
                    await controller.setDefaultAddress(address);
                  },
                );
              },
            ),
            ListTile(
              onTap: () {},
              leading: Icon(
                XIcons.location,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              minLeadingWidth: 20.0,
              title: Text(s.userCurrentLocation),
            ),
          ],
        ),
      ),
    );
  }
}
