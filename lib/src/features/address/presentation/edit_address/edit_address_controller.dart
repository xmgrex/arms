import 'package:arms/src/features/top_level_providers.dart';
import 'package:arms/src/service/shered_prefs_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/address_repository.dart';
import '../../domain/shipping_address.dart';
import 'edit_address_screen_state.dart';

final editAddressScreenControllerProvider = StateNotifierProvider.autoDispose.family<
    EditAddressScreenController, EditAddressScreenState, ShippingAddress>(
  (ref, address) {
    return EditAddressScreenController(address, ref.read);
  },
);

class EditAddressScreenController
    extends StateNotifier<EditAddressScreenState> {
  EditAddressScreenController(ShippingAddress address, this._read)
      : super(EditAddressScreenState(
          asyncValue: const AsyncValue.data(null),
          shippingAddress: address,
        )) {
    fullNameController.text = state.shippingAddress!.fullName;
    postalCodeController.text = state.shippingAddress!.postalCode;
    line1Controller.text = state.shippingAddress!.line1;
    line2Controller.text = state.shippingAddress!.line2;

    fullNameController.addListener(() {
      state = state.copyWith(
        shippingAddress: state.shippingAddress?.copyWith(
          fullName: fullNameController.text,
        ),
      );
    });
    postalCodeController.addListener(() {
      state = state.copyWith(
        shippingAddress: state.shippingAddress?.copyWith(
          postalCode: postalCodeController.text,
        ),
      );
    });
    line1Controller.addListener(() {
      state = state.copyWith(
        shippingAddress: state.shippingAddress?.copyWith(
          line1: line1Controller.text,
        ),
      );
    });
    line2Controller.addListener(() {
      state = state.copyWith(
        shippingAddress: state.shippingAddress?.copyWith(
          line2: line2Controller.text,
        ),
      );
    });
  }

  final Reader _read;
  final fullNameController = TextEditingController();
  final postalCodeController = TextEditingController();
  final line1Controller = TextEditingController();
  final line2Controller = TextEditingController();
  var instruction = DeliveryInstruction.noSetup;

  void onStateChanged(String value) {
    state = state.copyWith(
      shippingAddress: state.shippingAddress?.copyWith(
        state: value,
      ),
    );
  }

  void onCityChanged(String value) {
    state = state.copyWith(
      shippingAddress: state.shippingAddress?.copyWith(
        city: value,
      ),
    );
  }

  void onDeliveryInstructionChanged(DeliveryInstruction value) {
    instruction = value;
    state = state.copyWith(
      shippingAddress: state.shippingAddress?.copyWith(
        instruction: displayDeliveryInstruction(value),
      ),
    );
  }

  Future<void> editShippingAddress() async {
    state = state.copyWith(asyncValue: const AsyncValue.loading());
    final user = _read(appUserStateProvider);

    var addresses = <ShippingAddress>[];
    addresses = user!.addresses;
    final index = addresses.indexWhere((e) {
      return e.id == state.shippingAddress!.id;
    });
    addresses[index] = state.shippingAddress!;
    final afterUser = user.copyWith(addresses: addresses);

    final result = await AsyncValue.guard(() async {
      await _read(addressRepositoryProvider)
          .editShippingAddress(afterUser)
          .then((_) {
        fullNameController.clear();
        postalCodeController.clear();
        line1Controller.clear();
        line2Controller.clear();
        instruction = DeliveryInstruction.noSetup;
      });
      await _read(sharedPrefsManagerProvider)
          .setDefaultAddress(state.shippingAddress!);
    });
    state = state.copyWith(asyncValue: result);
  }
}
