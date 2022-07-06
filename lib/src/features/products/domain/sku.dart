import 'package:arms/src/constants/types.dart';
import 'package:arms/src/features/products/domain/size_option.dart';
import 'package:faker/faker.dart';
import 'package:x_kit/x_kit.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'color_option.dart';

class SKU {
  const SKU({
    required this.productId,
    required this.id,
    required this.name,
    required this.caption,
    required this.description,
    required this.currency,
    required this.price,
    required this.discount,
    required this.taxRate,
    required this.inventory,
    required this.isAvailable,
    required this.tags,
    required this.imageUrls,
    this.productReference,
    this.color,
    this.size,
  });

  factory SKU.fromMap(Map<String, dynamic> map) {

    return SKU(
      productId: map['productId'] as String,
      id: map['id'] as String,
      name: map['name'] as String,
      caption: map['caption'] as String,
      description: map['description'] as String,
      currency: map['currency'] as String,
      productReference: map['productReference'] as DocumentReference,
      price: map['price'] as double,
      discount: Discount.fromMap(map['discount'] as Map<String, dynamic>),
      taxRate: map['taxRate'] as double,
      inventory: map['inventory'] as int,
      isAvailable: map['isAvailable'] as bool,
      tags: map['tags'].cast<String>() as List<String>,
      imageUrls: map['imageUrls'].cast<String>() as List<String>,
      color: ColorOption.fromMap(map['color'] as Map<String, dynamic>),
      size: SizeOption.fromMap(map['size'] as Map<String, dynamic>),
    );
  }

  final String productId;
  final String id;
  final String name;
  final String caption;
  final String description;
  final String currency;
  final double price;
  final Discount discount;
  final double taxRate;
  final int inventory;
  final bool isAvailable;
  final List<String> tags;
  final List<String> imageUrls;
  final DocumentReference? productReference;
  final ColorOption? color;
  final SizeOption? size;

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'id': id,
      'name': name,
      'caption': caption,
      'description': description,
      'productReference': productReference,
      'currency': currency,
      'prince': price,
      'discount': discount.toMap(),
      'taxRate': taxRate,
      'inventory': inventory,
      'isAvailable': isAvailable,
      'tags': tags,
      'imageUrls': imageUrls,
      'color': color!.toMap(),
      'size': size!.toMap(),
    }.cast<String, dynamic>();
  }

  String displayPrice() => symbolFormatter(price.round(), currency);

  String displaySubTotal() => symbolFormatter(subtotal().round(), currency);

  String displayTotal() {
    return symbolFormatter((price + price * taxRate / 100).round(), currency);
  }

  String displayDiscountTotal() => symbolFormatter(total().round(), currency);

  String displayDiscountRate() => '${discount.rate}%';

  String displayDiscountAmount() {
    return symbolFormatter(discount.amount.round(), currency);
  }

  double subtotal() {
    if (discount.type != DiscountType.none) {
      if (discount.type == DiscountType.rate) {
        return price - (price * (discount.rate / 100));
      } else {
        return price - discount.amount;
      }
    }
    return price;
  }

  double tax() => subtotal() * taxRate / 100;

  double total() => subtotal() + tax();

  @override
  String toString() {
    return 'SKU{productId: $productId, id: $id, name: $name, caption: $caption, description: $description, currency: $currency, price: $price, discount: $discount, taxRate: $taxRate, inventory: $inventory, isAvailable: $isAvailable, tags: $tags, imageUrls: $imageUrls, productReference: $productReference, color: ${color.toString()}, size: ${size.toString()}}';
  }
}