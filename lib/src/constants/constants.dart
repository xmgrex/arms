import 'package:arms/src/features/checkout/domain/scheduled_delivery_date.dart';
import 'package:flutterfire_ui/auth.dart';

class Constants {
  static const deliveryFee = 210.0;

  static const providerConfigs = [
    EmailProviderConfiguration(),
    PhoneProviderConfiguration(),
  ];

  static const deliveryTimes = <DeliveryTime>[
    DeliveryTime(
      type: DeliveryTimeZoneType.form11amTo12am,
      string: '午前中',
      hour: 11,
    ),
    DeliveryTime(
      type: DeliveryTimeZoneType.form12amTo13pm,
      string: '12:00 〜 13:00',
      hour: 12,
    ),
    DeliveryTime(
      type: DeliveryTimeZoneType.form13pmTo14pm,
      string: '13:00 〜 14:00',
      hour: 13,
    ),
    DeliveryTime(
      type: DeliveryTimeZoneType.form14pmTo15pm,
      string: '14:00 〜 15:00',
      hour: 14,
    ),
    DeliveryTime(
      type: DeliveryTimeZoneType.form15pmTo16pm,
      string: '15:00 〜 16:00',
      hour: 15,
    ),
    DeliveryTime(
      type: DeliveryTimeZoneType.form16pmTo17pm,
      string: '16:00 〜 17:00',
      hour: 16,
    ),
    DeliveryTime(
      type: DeliveryTimeZoneType.form17pmTo18pm,
      string: '17:00 〜 18:00',
      hour: 17,
    ),
    DeliveryTime(
      type: DeliveryTimeZoneType.form18pmTo19pm,
      string: '18:00 〜 19:00',
      hour: 18,
    ),
    DeliveryTime(
      type: DeliveryTimeZoneType.form19pmTo20pm,
      string: '19:00 〜 20:00',
      hour: 19,
    ),
    DeliveryTime(
      type: DeliveryTimeZoneType.form20pmTo21pm,
      string: '20:00 〜 21:00',
      hour: 20,
    ),
  ];
}
