import 'package:arms/src/features/address/domain/shipping_address.dart';
import 'package:arms/src/features/checkout/domain/scheduled_delivery_date.dart';

class DeliveryOptions {
  const DeliveryOptions({
    required this.address,
    required this.scheduledDeliveryDate,
  });

  factory DeliveryOptions.fromMap(Map<String, dynamic> map) {
    final address =  ShippingAddress.fromMap(map['address'] as Map<String, dynamic>);
    final scheduledDeliveryDate = ScheduledDeliveryDate.fromMap(
      map['scheduledDeliveryDate'] as Map<String, dynamic>,
    );
    return DeliveryOptions(
      address: address,
      scheduledDeliveryDate: scheduledDeliveryDate,
    );
  }

  final ShippingAddress address;
  final ScheduledDeliveryDate scheduledDeliveryDate;

//<editor-fold desc="Data Methods">

  @override
  String toString() {
    return 'DeliveryOptions{ address: ${address.toString()}, scheduledDeliveryDate: ${scheduledDeliveryDate.toString()},}';
  }

  DeliveryOptions copyWith({
    ShippingAddress? address,
    ScheduledDeliveryDate? scheduledDeliveryDate,
  }) {
    return DeliveryOptions(
      address: address ?? this.address,
      scheduledDeliveryDate:
          scheduledDeliveryDate ?? this.scheduledDeliveryDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'address': address.toMap(),
      'scheduledDeliveryDate': scheduledDeliveryDate.toMap(),
    };
  }

}
