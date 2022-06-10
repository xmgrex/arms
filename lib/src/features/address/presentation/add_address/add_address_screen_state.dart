import 'package:arms/src/features/address/domain/shipping_address.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddAddressScreenState {
  const AddAddressScreenState({
    required this.asyncValue,
    this.shippingAddress,
  });

  final AsyncValue asyncValue;
  final ShippingAddress? shippingAddress;

  Map<String, dynamic> toMap() {
    return {
      'asyncValue': asyncValue,
      'shippingAddress': shippingAddress,
    };
  }

  factory AddAddressScreenState.fromMap(Map<String, dynamic> map) {
    return AddAddressScreenState(
      asyncValue: map['asyncValue'] as AsyncValue,
      shippingAddress: map['shippingAddress'] as ShippingAddress,
    );
  }

  AddAddressScreenState copyWith({
    AsyncValue? asyncValue,
    ShippingAddress? shippingAddress,
  }) {
    return AddAddressScreenState(
      asyncValue: asyncValue ?? this.asyncValue,
      shippingAddress: shippingAddress ?? this.shippingAddress,
    );
  }
}