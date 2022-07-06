class ColorOption {
  final String color;
  final String colorCode;

//<editor-fold desc="Data Methods">

  const ColorOption({
    required this.color,
    required this.colorCode,
  });

  ColorOption copyWith({
    String? color,
    String? colorCode,
  }) {
    return ColorOption(
      color: color ?? this.color,
      colorCode: colorCode ?? this.colorCode,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'color': color,
      'colorCode': colorCode,
    };
  }

  factory ColorOption.fromMap(Map<String, dynamic> map) {
    return ColorOption(
      color: map['color'] as String,
      colorCode: map['colorCode'] as String,
    );
  }

  @override
  String toString() {
    return 'ColorOption{color: $color, colorCode: $colorCode}';
  }

//</editor-fold>
}