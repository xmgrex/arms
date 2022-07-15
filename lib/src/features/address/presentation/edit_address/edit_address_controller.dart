import 'package:arms/src/features/top_level_providers.dart';
import 'package:arms/src/service/shared_prefs_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/address_repository.dart';
import '../../domain/shipping_address.dart';
import 'edit_address_screen_state.dart';

final editAddressScreenFormKey = GlobalKey<FormState>();

final editAddressScreenControllerProvider = StateNotifierProvider.autoDispose
    .family<EditAddressScreenController, EditAddressScreenState,
        ShippingAddress>(
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
    fullNameController.text = address.fullName;
    postalCodeController.text = address.postalCode;
    localityController.text = address.locality;
    subLocalityController.text = address.subLocality;
    streetController.text = address.street;
    line1Controller.text = address.line1;
    line2Controller.text = address.line2;
    instruction = convertToDeliveryInstruction(address.instruction);

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
    localityController.addListener(() {
      state = state.copyWith(
        shippingAddress: state.shippingAddress?.copyWith(
          locality: localityController.text,
        ),
      );
    });
    streetController.addListener(() {
      state = state.copyWith(
        shippingAddress: state.shippingAddress?.copyWith(
          street: streetController.text,
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
  final localityController = TextEditingController();
  final subLocalityController = TextEditingController();
  final streetController = TextEditingController();
  final line1Controller = TextEditingController();
  final line2Controller = TextEditingController();
  var instruction = DeliveryInstruction.noSetup;

  void onStateChanged(String value) {
    state = state.copyWith(
      shippingAddress: state.shippingAddress?.copyWith(
        administrativeArea: value,
      ),
    );
  }

  void onCityChanged(String value) {
    state = state.copyWith(
      shippingAddress: state.shippingAddress?.copyWith(
        locality: value,
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
    if (editAddressScreenFormKey.currentState!.validate()) {
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
          localityController.clear();
          streetController.clear();
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
}
