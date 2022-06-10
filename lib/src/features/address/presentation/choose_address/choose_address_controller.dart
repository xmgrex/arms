import 'package:arms/src/features/address/data/address_repository.dart';
import 'package:arms/src/features/address/presentation/choose_address/choose_address_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/shipping_address.dart';

final chooseAddressControllerProvider =
    StateNotifierProvider.autoDispose<ChooseAddressController, ChooseAddressState>((ref) {
  const state = ChooseAddressState(asyncValue: AsyncValue.data(null));
  final addressRepository = ref.watch(addressRepositoryProvider);
  return ChooseAddressController(state, addressRepository);
});

class ChooseAddressController extends StateNotifier<ChooseAddressState> {
  ChooseAddressController(ChooseAddressState state, this.addressRepository)
      : super(state) {
    getDefaultAddressId();
  }

  final AddressRepository addressRepository;

  Future<void> getDefaultAddressId() async {
    String? id;
    state = state.copyWith(asyncValue: const AsyncValue.loading());
    state = state.copyWith(
        asyncValue: await AsyncValue.guard(() async {
      id = await addressRepository.getDefaultAddressId();
    }));
    state = state.copyWith(defaultAddressId: id);
  }

  Future<void> setDefaultAddress(ShippingAddress address) async {
    await addressRepository.setDefaultAddress(address);
    await getDefaultAddressId();
  }

}
