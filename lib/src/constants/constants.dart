import 'package:arms/src/features/checkout/domain/scheduled_delivery_date.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';

const kPrimaryColor = Color(0xFFFF7643);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);

const kAnimationDuration = Duration(milliseconds: 300);

const gap0 = SizedBox();

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

class FormError {
  static final RegExp emailValidatorRegExp =
  RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  static const String kEmailNullError = "Please Enter your email";
  static const String kInvalidEmailError = "Please Enter Valid Email";
  static const String kPassNullError = "Please Enter your password";
  static const String kShortPassError = "Password is too short";
  static const String kMatchPassError = "Passwords don't match";
  static const String kNameNullError = "Please Enter your name";
  static const String kPhoneNumberNullError = "Please Enter your phone number";
  static const String kAddressNullError = "Please Enter your address";
}
