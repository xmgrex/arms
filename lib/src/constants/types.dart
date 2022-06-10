enum DiscountType {
  absolute,
  rate,
  none,
}

class Discount {
  const Discount({
    this.type = DiscountType.rate,
    this.amount = 0,
    this.rate = 0,
  });

  factory Discount.fromMap(Map<String, dynamic> map) {
    late DiscountType discountType;
    final type = map['type'] as String;
    for(var value in DiscountType.values) {
      if (type == value.name) {
        discountType = value;
      }
    }

    return Discount(
      type: discountType,
      amount: map['amount'] as double,
      rate: map['rate'] as double,
    );
  }

  final DiscountType type;
  final double amount;
  final double rate;

  Map<String, dynamic> toMap() {
    return {
      'type': type.name,
      'amount': amount,
      'rate': rate,
    };
  }

  @override
  String toString() {
    return 'Discount{type: $type, amount: $amount, rate: $rate}';
  }
}
