import 'package:arms/src/constants/constants.dart';
import 'package:x_kit/x_kit.dart';

import '../../payment/domain/credit_card.dart';
import '../../cart/domain/cart.dart';

class PaymentSummary {
  const PaymentSummary({
    this.creditCard,
    required this.subTotalAmount,
    required this.deliveryFee,
    required this.orderTotalAmount,
  });

  factory PaymentSummary.fromMap(Map<String, dynamic> map) {
    return PaymentSummary(
      creditCard: CreditCard.fromMap(map['creditCard'] as Map<String, dynamic>),
      subTotalAmount: map['subTotalAmount'] as double,
      deliveryFee: map['deliveryFee'] as double,
      orderTotalAmount: map['orderTotalAmount'] as double,
    );
  }

  factory PaymentSummary.init(List<CartItem> cartItems) {
    double subTotal = 0.0;
    for (var item in cartItems) {
      logger.info(item.total());
      subTotal += (item.total() * item.quantity);
    }

    return PaymentSummary(
      subTotalAmount: subTotal,
      deliveryFee: Constants.deliveryFee,
      orderTotalAmount: subTotal + Constants.deliveryFee,
    );
  }

  final CreditCard? creditCard;
  final double subTotalAmount;
  final double deliveryFee;
  final double orderTotalAmount;

  Map<String, dynamic> toMap() {
    return {
      'creditCard': creditCard!.toMap(),
      'subTotalAmount': subTotalAmount,
      'deliveryFee': deliveryFee,
      'orderTotalAmount': orderTotalAmount,
    };
  }

  PaymentSummary copyWith({
    CreditCard? creditCard,
    double? subTotalAmount,
    double? deliveryFee,
    double? orderTotalAmount,
  }) {
    return PaymentSummary(
      creditCard: creditCard ?? this.creditCard,
      subTotalAmount: subTotalAmount ?? this.subTotalAmount,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      orderTotalAmount: orderTotalAmount ?? this.orderTotalAmount,
    );
  }

  @override
  String toString() {
    return 'PaymentSummary{creditCard: $creditCard, subTotalAmount: $subTotalAmount, deliveryFee: $deliveryFee, orderTotalAmount: $orderTotalAmount}';
  }

  String displayOrderTotalAmount(String currency) {
    return symbolFormatter(orderTotalAmount.round(), currency);
  }

  String displayDeliveryFee(String currency) {
    return symbolFormatter(deliveryFee.round(), currency);
  }

  String displaySubTotalAmount(String currency) {
    return symbolFormatter(subTotalAmount.round(), currency);
  }

}
