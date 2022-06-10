class Location {

  const Location({
    required this.latitude,
    required this.longitude,
    required this.postalCode,
    required this.country,
    required this.city,
    required this.state,
    required this.line1,
    required this.line2,
  });

  factory Location.fromMap(Map<String, dynamic> map) {
    return Location(
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
      postalCode: map['postalCode'] as String,
      country: map['country'] as String,
      city: map['city'] as String,
      state: map['state'] as String,
      line1: map['line1'] as String,
      line2: map['line2'] as String,
    );
  }

  final double latitude;
  final double longitude;
  final String postalCode;
  final String country;
  final String city;
  final String state;
  final String line1;
  final String line2;

  Map<String, dynamic> toMap() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'postalCode': postalCode,
      'country': country,
      'city': city,
      'state': state,
      'line1': line1,
      'line2': line2,
    };
  }

  Location copyWith({
    double? latitude,
    double? longitude,
    String? postalCode,
    String? country,
    String? city,
    String? state,
    String? line1,
    String? line2,
  }) {
    return Location(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      postalCode: postalCode ?? this.postalCode,
      country: country ?? this.country,
      city: city ?? this.city,
      state: state ?? this.state,
      line1: line1 ?? this.line1,
      line2: line2 ?? this.line2,
    );
  }

  @override
  String toString() {
    return 'Location{latitude: $latitude, longitude: $longitude, postalCode: $postalCode, country: $country, city: $city, state: $state, line1: $line1, line2: $line2}';
  }
}