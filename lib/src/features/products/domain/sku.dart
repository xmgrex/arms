import 'package:arms/src/constants/types.dart';
import 'package:arms/src/features/products/domain/product_option.dart';
import 'package:x_kit/x_kit.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class SKU {
  const SKU({
    required this.productId,
    required this.optionValues,
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
  });

  factory SKU.fromMap(Map<String, dynamic> map) {
    final optionValues = map['optionValues'].cast<Map<String, dynamic>>()
        as List<Map<String, dynamic>>;

    return SKU(
      productId: map['productId'] as String,
      optionValues: optionValues.map((e) => OptionValue.fromMap(e)).toList(),
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
    );
  }

  final String productId;
  final List<OptionValue> optionValues;
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

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'optionValues': optionValues,
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
    return 'SKU{productId: $productId, optionValues: ${optionValues.toString()}, id: $id, name: $name, caption: $caption, description: $description, currency: $currency, price: $price, discount: $discount, taxRate: $taxRate, inventory: $inventory, isAvailable: $isAvailable, tags: $tags, imageUrls: $imageUrls, productReference: $productReference}';
  }
}
