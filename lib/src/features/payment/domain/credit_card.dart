import 'package:x_kit/x_kit.dart';

class CreditCard {
  const CreditCard({
    required this.id,
    required this.fingerprint,
    required this.brand,
    required this.country,
    required this.expYear,
    required this.expMonth,
    required this.funding,
    required this.last4,
  });

  factory CreditCard.fromJson(Map<String, dynamic> map) {
    return CreditCard(
      id: map['id'] as String,
      fingerprint: map['card']['fingerprint'] as String,
      brand: map['card']['brand'] as String,
      country: map['card']['country'] as String,
      expYear: map['card']['exp_year'] as int,
      expMonth: map['card']['exp_month'] as int,
      funding: map['card']['funding'] as String,
      last4: map['card']['last4'] as String,
    );
  }

  factory CreditCard.fromMap(Map<String, dynamic> map) {
    logger.info(map['fingerprint'].runtimeType);
    return CreditCard(
      id: map['id'] == null ? '' : map['id'] as String,
      fingerprint:  map['fingerprint'] == null ? '' : map['fingerprint'] as String,
      brand: map['brand'] as String,
      country: map['country'] as String,
      expYear: map['expYear'] as int,
      expMonth: map['expMonth'] as int,
      funding: map['funding'] as String,
      last4: map['last4'] as String,
    );
  }

  final String id;
  final String fingerprint;
  final String brand;
  final String country;
  final int expYear;
  final int expMonth;
  final String funding;
  final String last4;

  @override
  String toString() {
    return '''
CreditCard{ id: $id, fingerprint: $fingerprint, brand: $brand, country: $country, expYear: $expYear, expMonth: $expMonth, funding: $funding, last4: $last4,}''';
  }

  CreditCard copyWith({
    String? id,
    String? fingerprint,
    String? brand,
    String? country,
    int? expYear,
    int? expMonth,
    String? funding,
    String? last4,
  }) {
    return CreditCard(
      id: id ?? this.id,
      fingerprint: fingerprint ?? this.fingerprint,
      brand: brand ?? this.brand,
      country: country ?? this.country,
      expYear: expYear ?? this.expYear,
      expMonth: expMonth ?? this.expMonth,
      funding: funding ?? this.funding,
      last4: last4 ?? this.last4,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fingerprint': fingerprint,
      'brand': brand,
      'country': country,
      'expYear': expYear,
      'expMonth': expMonth,
      'funding': funding,
      'last4': last4,
    }.cast<String, dynamic>();
  }
//</editor-fold>
}
