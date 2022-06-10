import 'product_option.dart';

class Product {
  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.options,
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    final options = map['options'].cast<Map<String, dynamic>>()
        as List<Map<String, dynamic>>;
    return Product(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      imageUrl: map['imageUrl'] == null ? '' : map['imageUrl'] as String,
      options: options.map((e) => ProductOption.fromMap(e)).toList(),
    );
  }

  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final List<ProductOption> options;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'options': options,
    };
  }

  @override
  String toString() {
    return 'Product{id: $id, name: $name, description: $description, imageUrl: $imageUrl, options: ${options.toString()}}';
  }
}
