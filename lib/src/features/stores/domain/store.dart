import 'package:cloud_firestore/cloud_firestore.dart';

// images: map['images'].cast<String>() as List<String>,
// additionalInputItems: map['additionalInputItems'].cast<String>() as List<String>,

class Store {
  const Store({
    this.latitude,
    this.longitude,
    this.postalCode,
    this.country,
    this.administrativeArea,
    this.locality,
    this.subLocality,
    this.premise,
    this.name,
    required this.id,
    this.images,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Store.fromMap(Map<String, dynamic> map) {
    return Store(
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
      postalCode: map['postalCode'] as String,
      country: map['country'] as String,
      administrativeArea: map['administrativeArea'] as String,
      locality: map['locality'] as String,
      subLocality: map['subLocality'] as String,
      premise: map['premise'] as String,
      name: map['name'] as String,
      id: map['id'] as String,
      images: map['images'].cast<String>() as List<String>,
      createdAt: map['createdAt'] as Timestamp,
      updatedAt: map['updatedAt'] as Timestamp,
    );
  }

  final double? latitude;
  final double? longitude;
  final String? postalCode;
  final String? country;
  final String? administrativeArea;
  final String? locality;
  final String? subLocality;
  final String? premise;
  final String? name;
  final String id;
  final List<String>? images;
  final Timestamp createdAt;
  final Timestamp updatedAt;

  ///administrativeArea
  ///locality
  ///subthoroughfare
  ///

  Store copyWith({
    double? latitude,
    double? longitude,
    String? postalCode,
    String? country,
    String? administrativeArea,
    String? locality,
    String? subLocality,
    String? premise,
    String? name,
    String? id,
    List<String>? images,
    Timestamp? createdAt,
    Timestamp? updatedAt,
  }) {
    return Store(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      postalCode: postalCode ?? this.postalCode,
      country: country ?? this.country,
      administrativeArea: administrativeArea ?? this.administrativeArea,
      locality: locality ?? this.locality,
      subLocality: subLocality ?? this.subLocality,
      premise: premise ?? this.premise,
      name: name ?? this.name,
      id: id ?? this.id,
      images: images ?? this.images,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

//<editor-fold desc="Data Methods">

  String formattedAddress() {
    return '$postalCode $administrativeArea$locality$subLocality$premise';
  }

  static Store create() {
    return Store(
      id: '',
      country: '',
      postalCode: '6610045',
      administrativeArea: '兵庫県',
      locality: '尼崎市武庫豊町',
      subLocality: '3丁目4-1',
      premise: '',
      images: [],
      createdAt: Timestamp.now(),
      updatedAt: Timestamp.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'postalCode': postalCode,
      'country': country,
      'administrativeArea': administrativeArea,
      'locality': locality,
      'subLocality': subLocality,
      'premise': premise,
      'name': name,
      'id': id,
      'images': images,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    }.cast<String, dynamic>();
  }

  @override
  String toString() {
    return 'Store{latitude: $latitude, longitude: $longitude, postalCode: $postalCode, country: $country, administrativeArea: $administrativeArea, locality: $locality, subLocality: $subLocality, premise: $premise, name: $name, id: $id, images: $images, createdAt: $createdAt, updatedAt: $updatedAt}';
  } //</editor-fold>


}
