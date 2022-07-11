// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Input keywords`
  String get inputKeywords {
    return Intl.message(
      'Input keywords',
      name: 'inputKeywords',
      desc: '',
      args: [],
    );
  }

  /// `Special for you`
  String get specialForYou {
    return Intl.message(
      'Special for you',
      name: 'specialForYou',
      desc: '',
      args: [],
    );
  }

  /// `Popular Products`
  String get popularProducts {
    return Intl.message(
      'Popular Products',
      name: 'popularProducts',
      desc: '',
      args: [],
    );
  }

  /// `No products found`
  String get noProductsFound {
    return Intl.message(
      'No products found',
      name: 'noProductsFound',
      desc: '',
      args: [],
    );
  }

  /// `Add to cart`
  String get addToCart {
    return Intl.message(
      'Add to cart',
      name: 'addToCart',
      desc: '',
      args: [],
    );
  }

  /// `Quantity`
  String get quantity {
    return Intl.message(
      'Quantity',
      name: 'quantity',
      desc: '',
      args: [],
    );
  }

  /// `tax inclusive`
  String get taxInclusive {
    return Intl.message(
      'tax inclusive',
      name: 'taxInclusive',
      desc: '',
      args: [],
    );
  }

  /// `Featured Stores`
  String get featuredStores {
    return Intl.message(
      'Featured Stores',
      name: 'featuredStores',
      desc: '',
      args: [],
    );
  }

  /// `Cart is empty.`
  String get cartIsEmpty {
    return Intl.message(
      'Cart is empty.',
      name: 'cartIsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get total {
    return Intl.message(
      'Total',
      name: 'total',
      desc: '',
      args: [],
    );
  }

  /// `Sub total`
  String get subTotal {
    return Intl.message(
      'Sub total',
      name: 'subTotal',
      desc: '',
      args: [],
    );
  }

  /// `Order total`
  String get orderTotal {
    return Intl.message(
      'Order total',
      name: 'orderTotal',
      desc: '',
      args: [],
    );
  }

  /// `Account Info`
  String get accountInfo {
    return Intl.message(
      'Account Info',
      name: 'accountInfo',
      desc: '',
      args: [],
    );
  }

  /// `Account Settings`
  String get accountSettings {
    return Intl.message(
      'Account Settings',
      name: 'accountSettings',
      desc: '',
      args: [],
    );
  }

  /// `Addresses`
  String get addresses {
    return Intl.message(
      'Addresses',
      name: 'addresses',
      desc: '',
      args: [],
    );
  }

  /// `Payment methods`
  String get paymentMethods {
    return Intl.message(
      'Payment methods',
      name: 'paymentMethods',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Accessibility`
  String get accessibility {
    return Intl.message(
      'Accessibility',
      name: 'accessibility',
      desc: '',
      args: [],
    );
  }

  /// `Edit Email`
  String get editEmail {
    return Intl.message(
      'Edit Email',
      name: 'editEmail',
      desc: '',
      args: [],
    );
  }

  /// `Current email address`
  String get currentEmail {
    return Intl.message(
      'Current email address',
      name: 'currentEmail',
      desc: '',
      args: [],
    );
  }

  /// `New email address`
  String get newEmail {
    return Intl.message(
      'New email address',
      name: 'newEmail',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Edit password`
  String get editPassword {
    return Intl.message(
      'Edit password',
      name: 'editPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your current email address.`
  String get pleaseEnterCurrentEmail {
    return Intl.message(
      'Please enter your current email address.',
      name: 'pleaseEnterCurrentEmail',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your new email address.`
  String get pleaseEnterNewEmail {
    return Intl.message(
      'Please enter your new email address.',
      name: 'pleaseEnterNewEmail',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your password.`
  String get pleaseEnterPassword {
    return Intl.message(
      'Please enter your password.',
      name: 'pleaseEnterPassword',
      desc: '',
      args: [],
    );
  }

  /// `No Email.`
  String get noEmail {
    return Intl.message(
      'No Email.',
      name: 'noEmail',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Verified`
  String get verified {
    return Intl.message(
      'Verified',
      name: 'verified',
      desc: '',
      args: [],
    );
  }

  /// `Unverified`
  String get unverified {
    return Intl.message(
      'Unverified',
      name: 'unverified',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `No name.`
  String get noName {
    return Intl.message(
      'No name.',
      name: 'noName',
      desc: '',
      args: [],
    );
  }

  /// `Edit name.`
  String get editName {
    return Intl.message(
      'Edit name.',
      name: 'editName',
      desc: '',
      args: [],
    );
  }

  /// `OFF`
  String get off {
    return Intl.message(
      'OFF',
      name: 'off',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Color`
  String get color {
    return Intl.message(
      'Color',
      name: 'color',
      desc: '',
      args: [],
    );
  }

  /// `Size`
  String get size {
    return Intl.message(
      'Size',
      name: 'size',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Cart`
  String get cart {
    return Intl.message(
      'Cart',
      name: 'cart',
      desc: '',
      args: [],
    );
  }

  /// `Order`
  String get order {
    return Intl.message(
      'Order',
      name: 'order',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get account {
    return Intl.message(
      'Account',
      name: 'account',
      desc: '',
      args: [],
    );
  }

  /// `Search products`
  String get searchProducts {
    return Intl.message(
      'Search products',
      name: 'searchProducts',
      desc: '',
      args: [],
    );
  }

  /// `See More`
  String get seeMore {
    return Intl.message(
      'See More',
      name: 'seeMore',
      desc: '',
      args: [],
    );
  }

  /// `No payment method has been set up`
  String get noPaymentMethod {
    return Intl.message(
      'No payment method has been set up',
      name: 'noPaymentMethod',
      desc: '',
      args: [],
    );
  }

  /// `Add payment method`
  String get addPaymentMethod {
    return Intl.message(
      'Add payment method',
      name: 'addPaymentMethod',
      desc: '',
      args: [],
    );
  }

  /// `Add credit card`
  String get addCreditCard {
    return Intl.message(
      'Add credit card',
      name: 'addCreditCard',
      desc: '',
      args: [],
    );
  }

  /// `Enter your card information`
  String get enterYourCardInfo {
    return Intl.message(
      'Enter your card information',
      name: 'enterYourCardInfo',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message(
      'Done',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Add address`
  String get addAddress {
    return Intl.message(
      'Add address',
      name: 'addAddress',
      desc: '',
      args: [],
    );
  }

  /// `Edit address`
  String get editAddress {
    return Intl.message(
      'Edit address',
      name: 'editAddress',
      desc: '',
      args: [],
    );
  }

  /// `Choose address`
  String get chooseAddress {
    return Intl.message(
      'Choose address',
      name: 'chooseAddress',
      desc: '',
      args: [],
    );
  }

  /// `Add new address`
  String get addNewAddress {
    return Intl.message(
      'Add new address',
      name: 'addNewAddress',
      desc: '',
      args: [],
    );
  }

  /// `User current location`
  String get userCurrentLocation {
    return Intl.message(
      'User current location',
      name: 'userCurrentLocation',
      desc: '',
      args: [],
    );
  }

  /// `Postal code`
  String get postalCode {
    return Intl.message(
      'Postal code',
      name: 'postalCode',
      desc: '',
      args: [],
    );
  }

  /// `example: 0001111`
  String get examplePostalCode {
    return Intl.message(
      'example: 0001111',
      name: 'examplePostalCode',
      desc: '',
      args: [],
    );
  }

  /// `Administrative area`
  String get administrativeArea {
    return Intl.message(
      'Administrative area',
      name: 'administrativeArea',
      desc: '',
      args: [],
    );
  }

  /// `例: 東京都`
  String get exampleAdministrativeArea {
    return Intl.message(
      '例: 東京都',
      name: 'exampleAdministrativeArea',
      desc: '',
      args: [],
    );
  }

  /// `Locality`
  String get locality {
    return Intl.message(
      'Locality',
      name: 'locality',
      desc: '',
      args: [],
    );
  }

  /// `example: 〇〇City〇〇Town`
  String get exampleLocality {
    return Intl.message(
      'example: 〇〇City〇〇Town',
      name: 'exampleLocality',
      desc: '',
      args: [],
    );
  }

  /// `Street`
  String get street {
    return Intl.message(
      'Street',
      name: 'street',
      desc: '',
      args: [],
    );
  }

  /// `example: 1-2-3`
  String get exampleStreet {
    return Intl.message(
      'example: 1-2-3',
      name: 'exampleStreet',
      desc: '',
      args: [],
    );
  }

  /// `Building name/Company Name(optional)`
  String get line1 {
    return Intl.message(
      'Building name/Company Name(optional)',
      name: 'line1',
      desc: '',
      args: [],
    );
  }

  /// `example: 〇〇マンション`
  String get exampleLine1 {
    return Intl.message(
      'example: 〇〇マンション',
      name: 'exampleLine1',
      desc: '',
      args: [],
    );
  }

  /// `Room number(optional)`
  String get line2 {
    return Intl.message(
      'Room number(optional)',
      name: 'line2',
      desc: '',
      args: [],
    );
  }

  /// `example: 123`
  String get exampleLine2 {
    return Intl.message(
      'example: 123',
      name: 'exampleLine2',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your name.`
  String get nameFromValidator {
    return Intl.message(
      'Please enter your name.',
      name: 'nameFromValidator',
      desc: '',
      args: [],
    );
  }

  /// `Please enter postal code.`
  String get postalCodeFromValidator {
    return Intl.message(
      'Please enter postal code.',
      name: 'postalCodeFromValidator',
      desc: '',
      args: [],
    );
  }

  /// `Please enter locality.`
  String get localityFromValidator {
    return Intl.message(
      'Please enter locality.',
      name: 'localityFromValidator',
      desc: '',
      args: [],
    );
  }

  /// `Please enter sub locality.`
  String get subLocalityFromValidator {
    return Intl.message(
      'Please enter sub locality.',
      name: 'subLocalityFromValidator',
      desc: '',
      args: [],
    );
  }

  /// `Checkout`
  String get checkout {
    return Intl.message(
      'Checkout',
      name: 'checkout',
      desc: '',
      args: [],
    );
  }

  /// `Payment summary`
  String get paymentSummary {
    return Intl.message(
      'Payment summary',
      name: 'paymentSummary',
      desc: '',
      args: [],
    );
  }

  /// `Delivery options`
  String get deliveryOptions {
    return Intl.message(
      'Delivery options',
      name: 'deliveryOptions',
      desc: '',
      args: [],
    );
  }

  /// `Delivering to`
  String get deliveryTo {
    return Intl.message(
      'Delivering to',
      name: 'deliveryTo',
      desc: '',
      args: [],
    );
  }

  /// `Delivery instructions`
  String get deliveryInstructions {
    return Intl.message(
      'Delivery instructions',
      name: 'deliveryInstructions',
      desc: '',
      args: [],
    );
  }

  /// `No delivery instructions`
  String get noDeliveryInstructions {
    return Intl.message(
      'No delivery instructions',
      name: 'noDeliveryInstructions',
      desc: '',
      args: [],
    );
  }

  /// `Delivery window`
  String get deliveryWindow {
    return Intl.message(
      'Delivery window',
      name: 'deliveryWindow',
      desc: '',
      args: [],
    );
  }

  /// `Delivery fee`
  String get deliveryFee {
    return Intl.message(
      'Delivery fee',
      name: 'deliveryFee',
      desc: '',
      args: [],
    );
  }

  /// `Place order`
  String get placeOrder {
    return Intl.message(
      'Place order',
      name: 'placeOrder',
      desc: '',
      args: [],
    );
  }

  /// `Default`
  String get defaultStr {
    return Intl.message(
      'Default',
      name: 'defaultStr',
      desc: '',
      args: [],
    );
  }

  /// `Set as default card`
  String get setDefault {
    return Intl.message(
      'Set as default card',
      name: 'setDefault',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ja'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
