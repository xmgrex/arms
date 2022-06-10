import 'package:arms/src/features/address/domain/shipping_address.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditAddressScreenState {
  const EditAddressScreenState({
    required this.asyncValue,
    this.shippingAddress,
  });

  final AsyncValue asyncValue;
  final ShippingAddress? shippingAddress;

  EditAddressScreenState copyWith({
    AsyncValue? asyncValue,
    ShippingAddress? shippingAddress,
  }) {
    return EditAddressScreenState(
      asyncValue: asyncValue ?? this.asyncValue,
      shippingAddress: shippingAddress ?? this.shippingAddress,
    );
  }
}