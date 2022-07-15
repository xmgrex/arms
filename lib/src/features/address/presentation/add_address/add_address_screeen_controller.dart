import 'package:arms/src/features/address/data/address_repository.dart';
import 'package:arms/src/features/authentication/domain/app_user.dart';
import 'package:arms/src/features/top_level_providers.dart';
import 'package:arms/src/service/shared_prefs_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:x_kit/x_kit.dart';

import '../../domain/shipping_address.dart';
import 'add_address_screen_state.dart';

final addAddressScreenFormKey = GlobalKey<FormState>();

final addAddressScreenControllerProvider =
    StateNotifierProvider<AddAddressScreenController, AddAddressScreenState>(
        (ref) {
  return AddAddressScreenController(ref.read);
});

class AddAddressScreenController extends StateNotifier<AddAddressScreenState> {
  AddAddressScreenController(this._read)
      : super(AddAddressScreenState(
          asyncValue: const AsyncValue.data(null),
          shippingAddress: ShippingAddress.create(),
        )) {
    // fullNameController.addListener(() {
    //   state = state.copyWith(
    //     shippingAddress: state.shippingAddress?.copyWith(
    //       fullName: fullNameController.text,
    //     ),
    //   );
    // });
    // postalCodeController.addListener(() {
    //   state = state.copyWith(
    //     shippingAddress: state.shippingAddress?.copyWith(
    //       postalCode: postalCodeController.text,
    //     ),
    //   );
    // });
    // localityController.addListener(() {
    //   state = state.copyWith(
    //     shippingAddress: state.shippingAddress?.copyWith(
    //       locality: localityController.text,
    //     ),
    //   );
    // });
    // subLocalityController.addListener(() {
    //   state = state.copyWith(
    //     shippingAddress: state.shippingAddress?.copyWith(
    //       subLocality: subLocalityController.text,
    //     ),
    //   );
    // });
    // streetController.addListener(() {
    //   state = state.copyWith(
    //     shippingAddress: state.shippingAddress?.copyWith(
    //       street: streetController.text,
    //     ),
    //   );
    // });
    // line1Controller.addListener(() {
    //   state = state.copyWith(
    //     shippingAddress: state.shippingAddress?.copyWith(
    //       line1: line1Controller.text,
    //     ),
    //   );
    // });
    // line2Controller.addListener(() {
    //   state = state.copyWith(
    //     shippingAddress: state.shippingAddress?.copyWith(
    //       line2: line2Controller.text,
    //     ),
    //   );
    // });
  }

  final Reader _read;
  final fullNameController = TextEditingController();
  final postalCodeController = TextEditingController();
  final localityController = TextEditingController();
  final subLocalityController = TextEditingController();
  final streetController = TextEditingController();
  final line1Controller = TextEditingController();
  final line2Controller = TextEditingController();
  var instruction = DeliveryInstruction.noSetup;

  void onStateChanged(String value) {
    state = state.copyWith(
      shippingAddress: state.shippingAddress?.copyWith(
        locality: value,
      ),
    );
  }

  void onCityChanged(String value) {
    state = state.copyWith(
      shippingAddress: state.shippingAddress?.copyWith(
        subLocality: value,
      ),
    );
  }

  Future<void> addShippingAddress() async {
    final user = _read(appUserStateProvider);
    if (addAddressScreenFormKey.currentState!.validate()) {
      state = state.copyWith(asyncValue: const AsyncValue.loading());
      state = state.copyWith(
        shippingAddress: state.shippingAddress?.copyWith(
          fullName: fullNameController.text,
          postalCode: postalCodeController.text,
          locality: localityController.text,
          street: streetController.text,
          line1: line1Controller.text,
          line2: line2Controller.text,
        ),
      );


      final afterUser = user!.copyWith(addresses: [
        ...user.addresses,
        ...[state.shippingAddress!]
      ]);
      final result = await AsyncValue.guard(() async {
        await _read(addressRepositoryProvider)
            .addShippingAddress(afterUser)
            .then((_) {
          fullNameController.clear();
          postalCodeController.clear();
          localityController.clear();
          subLocalityController.clear();
          line1Controller.clear();
          line2Controller.clear();
          instruction = DeliveryInstruction.noSetup;
        });
        await _read(sharedPrefsManagerProvider)
            .setDefaultAddress(state.shippingAddress!);
      });
      state = state.copyWith(asyncValue: result);
    } else {
      return Future.error('Enter info');
    }
  }

  void onDeliveryInstructionChanged(DeliveryInstruction value) {
    instruction = value;
    state = state.copyWith(
      shippingAddress: state.shippingAddress?.copyWith(
        instruction: displayDeliveryInstruction(value),
      ),
    );
  }

  Future<void> getCurrentPosition() async {
    final shippingAddress =
        await _read(addressRepositoryProvider).getCurrentPosition();
    state = state.copyWith(shippingAddress: shippingAddress);
    postalCodeController.text = shippingAddress.postalCode;
    localityController.text = shippingAddress.locality;
    subLocalityController.text = shippingAddress.subLocality;
    streetController.text = shippingAddress.street;
    logger.info(shippingAddress.toString());
  }
}
