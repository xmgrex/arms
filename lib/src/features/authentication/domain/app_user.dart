import 'package:arms/src/features/address/domain/shipping_address.dart';
import 'package:x_kit/x_kit.dart';

import '../../payment/domain/credit_card.dart';

class AppUser {
  const AppUser({
    required this.uid,
    required this.addresses,
    required this.defaultCard,
  });

  factory AppUser.fromMap(Map<String, dynamic> map) {
    final maps = map['addresses'].cast<Map<String, dynamic>>()
        as List<Map<String, dynamic>>;

    return AppUser(
      uid: map['uid'] as String,
      addresses: maps.map((e) => ShippingAddress.fromMap(e)).toList(),
      defaultCard: map['defaultCard'] == null
          ? null
          : CreditCard.fromMap(map['defaultCard'] as Map<String, dynamic>),
    );
  }

  final String uid;
  final List<ShippingAddress> addresses;
  final CreditCard? defaultCard;

  @override
  String toString() {
    return 'User{ uid: $uid, addresses: $addresses, defaultCard: $defaultCard,}';
  }

  AppUser copyWith({
    String? uid,
    List<ShippingAddress>? addresses,
    CreditCard? defaultCard,
  }) {
    return AppUser(
      uid: uid ?? this.uid,
      addresses: addresses ?? this.addresses,
      defaultCard: defaultCard ?? this.defaultCard,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'addresses': addresses.map((e) => e.toMap()).toList(),
      'defaultCard': defaultCard?.toMap(),
    }.cast<String, dynamic>();
  }

//</editor-fold>
}
