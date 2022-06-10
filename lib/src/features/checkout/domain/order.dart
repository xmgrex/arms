import 'package:arms/src/features/cart/domain/cart.dart';
import 'package:arms/src/features/checkout/domain/delivery_options.dart';
import 'package:arms/src/features/checkout/domain/payment_summary.dart';
import 'package:arms/src/features/products/domain/sku.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import '../../../constants/types.dart';
import '../../authentication/domain/location.dart';

class OrderItem {
  const OrderItem({
    required this.productId,
    required this.skuId,
    required this.name,
    required this.caption,
    required this.description,
    required this.currency,
    required this.price,
    required this.discount,
    required this.taxRate,
    required this.imageUrls,
    this.productReference,
  });

  factory OrderItem.fromMap(Map<String, dynamic> map) {
    return OrderItem(
      productId: map['productId'] as String,
      skuId: map['skuId'] as String,
      name: map['name'] as String,
      caption: map['caption'] as String,
      description: map['description'] as String,
      currency: map['currency'] as String,
      price: map['price'] as double,
      discount: Discount.fromMap(map['discount'] as Map<String, dynamic>),
      taxRate: map['taxRate'] as double,
      imageUrls: map['imageUrls'].cast<String>() as List<String>,
      productReference: map['productReference'] as DocumentReference,
    );
  }

  factory OrderItem.fromCartItem(CartItem cartItem) {
    return OrderItem(
      productId: cartItem.product.id,
      skuId: cartItem.skuId,
      name: cartItem.name,
      caption: cartItem.caption,
      description: cartItem.description,
      currency: cartItem.currency,
      price: cartItem.amount,
      discount: cartItem.discount,
      taxRate: cartItem.taxRate,
      imageUrls: cartItem.imageUrls,
    );
  }

  final String productId;
  final String skuId;
  final String name;
  final String caption;
  final String description;
  final String currency;
  final double price;
  final Discount discount;
  final double taxRate;
  final List<String> imageUrls;
  final DocumentReference? productReference;

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'skuId': skuId,
      'name': name,
      'caption': caption,
      'description': description,
      'currency': currency,
      'price': price,
      'discount': discount.toMap(),
      'taxRate': taxRate,
      'imageUrls': imageUrls,
      'productReference': productReference,
    };
  }

  @override
  String toString() {
    return 'OrderItem{productId: $productId, skuId: $skuId, name: $name, caption: $caption, description: $description, currency: $currency, price: $price, discount: $discount, taxRate: $taxRate, imageUrls: $imageUrls, productReference: $productReference}';
  }
}

class Order {
  const Order({
    required this.id,
    required this.deliveryOptions,
    required this.paymentSummary,
    required this.customerId,
    required this.deliveryStatus,
    required this.currency,
    required this.paymentStatus,
    required this.refundStatus,
    required this.paymentMethod,
    required this.paymentResult,
    required this.items,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Order.fromMap(Map<String, dynamic> map) {
    final maps =
        map['items'].cast<Map<String, dynamic>>() as List<Map<String, dynamic>>;
    var orderItems = <OrderItem>[];
    for (var map in maps) {
      orderItems.add(OrderItem.fromMap(map));
    }

    return Order(
      id: map['id'] as String,
      deliveryOptions: DeliveryOptions.fromMap(
          map['deliveryOptions'] as Map<String, dynamic>),
      paymentSummary:
          PaymentSummary.fromMap(map['paymentSummary'] as Map<String, dynamic>),
      customerId: map['customerId'] as String,
      deliveryStatus: map['deliveryStatus'] as String,
      currency: map['currency'] as String,
      paymentStatus: map['paymentStatus'] as String,
      refundStatus: map['refundStatus'] as String,
      paymentMethod: map['paymentMethod'] as String,
      paymentResult: map['paymentResult'] as Map<String, dynamic>,
      items: orderItems,
      createdAt: map['createdAt'] as Timestamp,
      updatedAt: map['updatedAt'] as Timestamp,
    );
  }

  factory Order.create(
    DeliveryOptions deliveryOptions,
    PaymentSummary paymentSummary,
    List<CartItem> cartItems,
  ) {
    final orderItems = cartItems.map((e) => OrderItem.fromCartItem(e)).toList();

    return Order(
      id: const Uuid().v4(),
      deliveryOptions: deliveryOptions,
      paymentSummary: paymentSummary,
      customerId: '',
      deliveryStatus: 'preparing_for_delivery',
      currency: 'JPY',
      paymentStatus: '',
      refundStatus: '',
      paymentMethod: paymentSummary.creditCard!.id,
      paymentResult: {},
      items: orderItems,
      createdAt: Timestamp.now(),
      updatedAt: Timestamp.now(),
    );
  }

  final String id;
  final DeliveryOptions deliveryOptions;
  final PaymentSummary paymentSummary;

  ///
  /// delivered(配達、受け取り完了)
  /// preparing_for_delivery(商品準備中)
  /// out_for_delivery(配送しようとしているか、または集荷の準備ができています。)
  /// in_transit(キャリアが荷送人から貨物を受け取った、またはピックアップした状態です。貨物は配送中です。)
  /// failed_attempt(輸送業者が配送を試みたが失敗し、通常は通知を残して再配送を試みる)。
  /// exception(カスタムホールド、未配達、差出人に返送された荷物など、配送に関する例外があります。)
  /// expired(追加されてから30日間、追跡情報がない貨物です。)
  ///
  final String customerId;
  final String deliveryStatus;
  final String currency;
  final String paymentStatus;
  final String refundStatus;
  final String paymentMethod;
  final Map<String, dynamic> paymentResult;
  final List<OrderItem> items;
  final Timestamp createdAt;
  final Timestamp updatedAt;

  @override
  String toString() {
    return 'Order{ id: $id, deliveryOptions: ${deliveryOptions.toString()}, paymentSummary: ${paymentSummary.toString()}, customerId: $customerId, deliveryStatus: $deliveryStatus, currency: $currency, paymentStatus: $paymentStatus, refundStatus: $refundStatus, paymentMethod: $paymentMethod, paymentResult: $paymentResult, items: ${items.toString()}, createdAt: $createdAt, updatedAt: $updatedAt,}';
  }

  Order copyWith({
    String? id,
    DeliveryOptions? deliveryOptions,
    PaymentSummary? paymentSummary,
    String? customerId,
    String? deliveryStatus,
    String? currency,
    String? paymentStatus,
    String? refundStatus,
    String? paymentMethod,
    Map<String, dynamic>? paymentResult,
    List<OrderItem>? items,
    Timestamp? createdAt,
    Timestamp? updatedAt,
  }) {
    return Order(
      id: id ?? this.id,
      deliveryOptions: deliveryOptions ?? this.deliveryOptions,
      paymentSummary: paymentSummary ?? this.paymentSummary,
      customerId: customerId ?? this.customerId,
      deliveryStatus: deliveryStatus ?? this.deliveryStatus,
      currency: currency ?? this.currency,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      refundStatus: refundStatus ?? this.refundStatus,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      paymentResult: paymentResult ?? this.paymentResult,
      items: items ?? this.items,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    var l = <Map<String, dynamic>>[];
    for (var item in items) {
      l.add(item.toMap());
    }

    return {
      'id': id,
      'deliveryOptions': deliveryOptions.toMap(),
      'paymentSummary': paymentSummary.toMap(),
      'customerId': customerId,
      'deliveryStatus': deliveryStatus,
      'currency': currency,
      'paymentStatus': paymentStatus,
      'refundStatus': refundStatus,
      'paymentMethod': paymentMethod,
      'paymentResult': paymentResult,
      'items': l,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

//</editor-fold>
}
