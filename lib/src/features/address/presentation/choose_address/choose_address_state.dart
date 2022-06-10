import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChooseAddressState {

  const ChooseAddressState({
    this.defaultAddressId,
    required this.asyncValue,
  });

  final String? defaultAddressId;
  final AsyncValue asyncValue;

  ChooseAddressState copyWith({
    String? defaultAddressId,
    AsyncValue? asyncValue,
  }) {
    return ChooseAddressState(
      defaultAddressId: defaultAddressId ?? this.defaultAddressId,
      asyncValue: asyncValue ?? this.asyncValue,
    );
  }
}