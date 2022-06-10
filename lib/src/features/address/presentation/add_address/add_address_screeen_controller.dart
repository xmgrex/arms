import 'package:arms/src/features/address/data/address_repository.dart';
import 'package:arms/src/features/authentication/data/auth_repository.dart';
import 'package:arms/src/features/authentication/domain/app_user.dart';
import 'package:arms/src/features/authentication/presentation/account/app_user_notifier.dart';
import 'package:arms/src/features/top_level_providers.dart';
import 'package:arms/src/service/shered_prefs_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/shipping_address.dart';
import 'add_address_screen_state.dart';

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

  Future<void> addShippingAddress() async {
    state = state.copyWith(asyncValue: const AsyncValue.loading());
    AppUser? user;
    user = _read(appUserStateProvider);
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
