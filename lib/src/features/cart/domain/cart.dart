import 'package:arms/src/features/products/domain/product.dart';
import 'package:arms/src/features/products/domain/sku.dart';
import 'package:x_kit/x_kit.dart';

import '../../../constants/types.dart';

class CartItem {
  const CartItem({
    required this.product,
    required this.skuId,
    required this.name,
    required this.caption,
    required this.description,
    required this.currency,
    required this.amount,
    required this.quantity,
    required this.discount,
    required this.taxRate,
    required this.inventory,
    required this.imageUrls,
  });

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      product: Product.fromMap(map['product'] as Map<String, dynamic>),
      skuId: map['skuId'] as String,
      name: map['name'] as String,
      caption: map['caption'] as String,
      description: map['description'] as String,
      currency: map['currency'] as String,
      amount: map['amount'] as double,
      quantity: map['quantity'] as int,
      discount: Discount.fromMap(map['discount'] as Map<String, dynamic>),
      taxRate: map['taxRate'] as double,
      inventory: map['inventory'] as int,
      imageUrls: map['imageUrls'].cast<String>() as List<String>,
    );
  }

  factory CartItem.fromSKU(SKU sku, int quantity, Product product) {
    return CartItem(
      product: product,
      skuId: sku.id,
      name: sku.name,
      caption: sku.caption,
      description: sku.description,
      currency: sku.currency,
      amount: sku.price,
      quantity: quantity,
      discount: sku.discount,
      taxRate: sku.taxRate,
      inventory: sku.inventory,
      imageUrls: sku.imageUrls,
    );
  }

  final Product product;
  final String skuId;
  final String name;
  final String caption;
  final String description;
  final String currency;
  final double amount;
  final int quantity;
  final Discount discount;
  final double taxRate;
  final int inventory;
  final List<String> imageUrls;



  Map<String, dynamic> toMap() {
    return {
      'product': product.toMap(),
      'skuId': skuId,
      'name': name,
      'caption': caption,
      'description': description,
      'currency': currency,
      'amount': amount,
      'quantity': quantity,
      'discount': discount.toMap(),
      'taxRate': taxRate,
      'inventory': inventory,
      'imageUrls': imageUrls,
    };
  }

  @override
  String toString() {
    return 'CartItem{product: ${product.toString()}, skuId: $skuId, name: $name, caption: $caption, description: $description, currency: $currency, amount: $amount, quantity: $quantity, discount: ${discount.toString()}, taxRate: $taxRate, inventory: $inventory, imageUrls: $imageUrls}';
  }

  String displayPrice() => symbolFormatter(price.round(), currency);

  String displaySubTotal() => symbolFormatter(subtotal().round(), currency);

  String displayTotal() {
    return symbolFormatter((price + price * taxRate / 100).round(), currency);
  }

  String displayDiscountTotal() => symbolFormatter(total().round(), currency);

  String displayDiscountRate() => '${discount.rate}%';

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

  double get price => amount;

  CartItem copyWith({
  Product? product,
    String? skuId,
    String? name,
    String? caption,
    String? description,
    String? currency,
    double? amount,
    int? quantity,
    Discount? discount,
    double? taxRate,
    int? inventory,
    List<String>? imageUrls,
  }) {
    return CartItem(
      product: product ?? this.product,
      skuId: skuId ?? this.skuId,
      name: name ?? this.name,
      caption: caption ?? this.caption,
      description: description ?? this.description,
      currency: currency ?? this.currency,
      amount: amount ?? this.amount,
      quantity: quantity ?? this.quantity,
      discount: discount ?? this.discount,
      taxRate: taxRate ?? this.taxRate,
      inventory: inventory ?? this.inventory,
      imageUrls: imageUrls ?? this.imageUrls,
    );
  }
}

class Cart {
  const Cart({
    required this.id,
    required this.items,
  });

  factory Cart.fromMap(Map<String, dynamic> map) {
    final items =
        map['items'].cast<Map<String, dynamic>>() as List<Map<String, dynamic>>;

    return Cart(
      id: map['id'] as String,
      items: items.map((e) => CartItem.fromMap(e)).toList(),
    );
  }

  final String id;
  final List<CartItem> items;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'items': items,
    };
  }

  @override
  String toString() {
    return 'Cart{id: $id, items: ${items.toString()}}';
  }

  double total() {
    double total = 0;
    for (var item in items) {
      total += item.total();
    }
    return total;
  }
}
