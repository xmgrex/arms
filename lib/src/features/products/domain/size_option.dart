class SizeOption {
  final String size;
  final String value;

//<editor-fold desc="Data Methods">

  const SizeOption({
    required this.size,
    required this.value,
  });

  SizeOption copyWith({
    String? size,
    String? value,
  }) {
    return SizeOption(
      size: size ?? this.size,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'size': size,
      'value': value,
    };
  }

  factory SizeOption.fromMap(Map<String, dynamic> map) {
    return SizeOption(
      size: map['size'] as String,
      value: map['value'] as String,
    );
  }

  @override
  String toString() {
    return 'SizeOption{size: $size, value: $value}';
  }

//</editor-fold>
}