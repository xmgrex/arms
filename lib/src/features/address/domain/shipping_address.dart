import 'package:arms/src/features/checkout/presentation/delivery_option/delivery_options_widget.dart';
import 'package:uuid/uuid.dart';

enum DeliveryInstruction {
  noSetup,
  entrance,
  homeDeliveryBox,
  gasMeterBox,
  bicycleBasket,
  garage,
  inBuildingReceptionistOrCaretaker,
  noUseOfDeliveryService,
}

String displayDeliveryInstruction(DeliveryInstruction instruction) {
  switch (instruction) {
    case DeliveryInstruction.entrance:
      return '玄関';
    case DeliveryInstruction.homeDeliveryBox:
      return '宅配ボックス';
    case DeliveryInstruction.gasMeterBox:
      return 'ガスメーターボックス';
    case DeliveryInstruction.bicycleBasket:
      return '自転車のカゴ';
    case DeliveryInstruction.garage:
      return '車庫';
    case DeliveryInstruction.inBuildingReceptionistOrCaretaker:
      return '建物内受付/管理人';
    case DeliveryInstruction.noUseOfDeliveryService:
      return '置き配を利用しない';
    case DeliveryInstruction.noSetup:
      return '設定なし';
  }
}

DeliveryInstruction convertToDeliveryInstruction(String instruction) {
  switch (instruction) {
    case '玄関':
      return DeliveryInstruction.entrance;
    case '宅配ボックス':
      return DeliveryInstruction.homeDeliveryBox;
    case 'ガスメーターボックス':
      return DeliveryInstruction.gasMeterBox;
    case '自転車のカゴ':
      return DeliveryInstruction.bicycleBasket;
    case '車庫':
      return DeliveryInstruction.garage;
    case '建物内受付/管理人':
      return DeliveryInstruction.inBuildingReceptionistOrCaretaker;
    case '置き配を利用しない':
      return DeliveryInstruction.noUseOfDeliveryService;
    case '設定なし':
      return DeliveryInstruction.noSetup;
    default:
      return DeliveryInstruction.noSetup;
  }
}

class ShippingAddress {
  const ShippingAddress({
    required this.id,
    this.latitude,
    this.longitude,
    required this.fullName,
    required this.instruction,
    required this.postalCode,
    required this.country,
    required this.state,
    required this.city,
    required this.line1,
    required this.line2,
  });

  factory ShippingAddress.fromMap(Map<String, dynamic> map) {
    return ShippingAddress(
      latitude: map['latitude'] == null ? null : map['latitude'] as double,
      longitude: map['longitude'] == null ? null : map['longitude'] as double,
      id: map['id'] as String,
      fullName: map['fullName'] as String,
      instruction: map['instruction'] as String,
      postalCode: map['postalCode'] as String,
      country: map['country'] as String,
      state: map['state'] as String,
      city: map['city'] as String,
      line1: map['line1'] as String,
      line2: map['line2'] as String,
    );
  }

  factory ShippingAddress.create() {
    return ShippingAddress(
      id: const Uuid().v4(),
      fullName: '',
      instruction: '',
      postalCode: '',
      country: '',
      state: '',
      city: '',
      line1: '',
      line2: '',
    );
  }

  final double? latitude;
  final double? longitude;
  final String id;
  final String fullName;
  final String instruction;
  final String postalCode;
  final String country;
  final String state;
  final String city;
  final String line1;
  final String line2;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'latitude': latitude,
      'longitude': longitude,
      'fullName': fullName,
      'instruction': instruction,
      'postalCode': postalCode,
      'country': country,
      'state': state,
      'city': city,
      'line1': line1,
      'line2': line2,
    };
  }

  ShippingAddress copyWith({
    double? latitude,
    double? longitude,
    String? id,
    String? fullName,
    String? instruction,
    String? postalCode,
    String? country,
    String? state,
    String? city,
    String? line1,
    String? line2,
  }) {
    return ShippingAddress(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      instruction: instruction ?? this.instruction,
      postalCode: postalCode ?? this.postalCode,
      country: country ?? this.country,
      state: state ?? this.state,
      city: city ?? this.city,
      line1: line1 ?? this.line1,
      line2: line2 ?? this.line2,
    );
  }

  @override
  String toString() {
    return 'Location{latitude: $latitude, longitude: $longitude, fullName: $fullName, instruction: $instruction, postalCode: $postalCode, country: $country, city: $city, state: $state, line1: $line1, line2: $line2}';
  }

  String displayAddress() {
    return '$state$city$line1$line2';
  }

  String displayFullAddress() {
    return '〒$postalCode $state$city$line1$line2, $fullName';
  }
}
