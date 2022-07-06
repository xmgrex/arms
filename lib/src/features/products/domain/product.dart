import 'package:arms/src/constants/functions.dart';
import 'package:arms/src/features/products/domain/size_option.dart';
import 'color_option.dart';

class Product {
  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
    this.colors,
    this.sizes,
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    final colors = toListMap(map['colors']);
    final sizes = toListMap(map['sizes']);
    return Product(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      imageUrl: map['imageUrl'] == null ? '' : map['imageUrl'] as String,
      price: map['price'] == null ? 0.0 : map['price'] as double,
      colors: colors.map((e) => ColorOption.fromMap(e)).toList(),
      sizes: sizes.map((e) => SizeOption.fromMap(e)).toList(),
    );
  }

  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final double price;
  final List<ColorOption>? colors;
  final List<SizeOption>? sizes;


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'price': price,
      'colors': colors!.map((e) => e.toMap()).toList(),
      'sizes': sizes!.map((e) => e.toMap()).toList(),
    };
  }

  @override
  String toString() {
    return 'Product{id: $id, name: $name, description: $description, imageUrl: $imageUrl}';
  }
}
