class ProductOption {
  const ProductOption({
    required this.id,
    required this.name,
    required this.values,
  });

  factory ProductOption.fromMap(Map<String, dynamic> map) {
    final values = map['values'].cast<Map<String, dynamic>>()
        as List<Map<String, dynamic>>;
    return ProductOption(
      id: map['id'] as String,
      name: map['name'] as String,
      values: values.map((e) => OptionValue.fromMap(e)).toList(),
    );
  }

  final String id;
  final String name;
  final List<OptionValue> values;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'values': values.map((e) => e.toMap()).toList(),
    };
  }

  @override
  String toString() {
    return 'Option{id: $id, name: $name, values: ${values.toString()}}';
  }
}

class OptionValue {
  const OptionValue({
    required this.id,
    required this.optionId,
    required this.name,
    required this.value,
  });

  factory OptionValue.fromMap(Map<String, dynamic> map) {
    return OptionValue(
      id: map['id'] as String,
      optionId: map['optionId'] as String,
      name: map['name'] as String,
      value: map['value'] as String,
    );
  }

  final String id;
  final String optionId;
  final String name;
  final String value;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'optionId': optionId,
      'name': name,
      'value': value,
    };
  }

  @override
  String toString() {
    return 'OptionValue{id: $id, optionId: $optionId, name: $name, value: $value}';
  }
}
