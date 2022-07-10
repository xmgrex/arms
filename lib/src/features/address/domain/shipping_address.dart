import 'package:uuid/uuid.dart';

enum DeliveryInstruction {
  noSetup,
  entrance,
  homeDeliveryBox,
  gasMeterBox,
  garage,
  noUseOfDeliveryService,
}

String displayDeliveryInstruction(DeliveryInstruction instruction) {
  switch (instruction) {
    case DeliveryInstruction.entrance:
      return '玄関先に置く';
    case DeliveryInstruction.homeDeliveryBox:
      return '宅配ボックス';
    case DeliveryInstruction.gasMeterBox:
      return 'ガスメーターボックス';
    case DeliveryInstruction.garage:
      return '車庫';
    case DeliveryInstruction.noUseOfDeliveryService:
      return '置き配を利用しない';
    case DeliveryInstruction.noSetup:
      return '設定なし';
  }
}

DeliveryInstruction convertToDeliveryInstruction(String instruction) {
  switch (instruction) {
    case '玄関先に置く':
      return DeliveryInstruction.entrance;
    case '宅配ボックス':
      return DeliveryInstruction.homeDeliveryBox;
    case 'ガスメーターボックス':
      return DeliveryInstruction.gasMeterBox;
    case '車庫':
      return DeliveryInstruction.garage;
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
    required this.administrativeArea,
    required this.locality,
    required this.subLocality,
    required this.street,
    required this.line1,
    required this.line2,
  });

  factory ShippingAddress.fromMap(Map<String, dynamic> map) {
    return ShippingAddress(
      latitude: map['latitude'] == null ? 0.0 : map['latitude'] as double,
      longitude: map['longitude'] == null ? 0.0 : map['longitude'] as double,
      id: map['id'] as String,
      fullName: map['fullName'] as String,
      instruction: map['instruction'] as String,
      postalCode: map['postalCode'] as String,
      country: map['country'] as String,
      administrativeArea: map['administrativeArea'] as String,
      locality: map['locality'] as String,
      subLocality: map['subLocality'] as String,
      street: map['street'] as String,
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
      administrativeArea: '',
      locality: '',
      subLocality: '',
      street: '',
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
  final String administrativeArea;//都道府県
  final String locality;//市区郡町村
  final String subLocality;//丁目、番地
  final String street;//市区郡町村&丁目、番地
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
      'administrativeArea': administrativeArea,
      'locality': locality,
      'subLocality': subLocality,
      'street': street,
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
    String? administrativeArea,
    String? locality,
    String? subLocality,
    String? street,
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
      administrativeArea: administrativeArea ?? this.administrativeArea,
      locality: locality ?? this.locality,
      subLocality: subLocality ?? this.subLocality,
      street: street ?? this.street,
      line1: line1 ?? this.line1,
      line2: line2 ?? this.line2,
    );
  }


  @override
  String toString() {
    return 'ShippingAddress{latitude: $latitude, longitude: $longitude, id: $id, fullName: $fullName, instruction: $instruction, postalCode: $postalCode, country: $country, locality: $locality, subLocality: $subLocality, street: $street, line1: $line1, line2: $line2}';
  }

  String displayAddress() {
    return '$locality$subLocality$line1$line2';
  }

  String displayFullAddress() {
    return '〒$postalCode $administrativeArea$locality$subLocality$street$line1$line2, $fullName';
  }
}

