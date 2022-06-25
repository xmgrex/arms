import 'package:arms/src/features/authentication/domain/app_user.dart';
import 'package:arms/src/features/address/domain/shipping_address.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_services/firestore_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:x_kit/x_kit.dart';

import '../../features/cart/domain/cart.dart';

final firestoreServiceProvider = Provider.autoDispose((_) {
  return FirestoreService.instance;
});

final firestoreInstanceProvider = Provider.autoDispose((_) {
  return FirebaseFirestore.instance;
});

class FirestorePath {
  static const _carts = 'carts';
  static const _orders = 'orders';
  static const _creditCards = 'creditCards';
  static const _users = 'users';
  static const _customers = 'customers';
  static const _version = 'v1';

  static String user(String uid) => 'commerce/$_version/$_users/$uid';

  static String order(String uid, String orderId) => 'commerce/$_version/$_users/$uid/$_orders/$orderId';

  static String orders(String uid) => 'commerce/$_version/$_users/$uid/$_orders';

  static String customer(String uid) => 'commerce/$_version/$_customers/$uid';

  static String cartItem(String uid, String id) => '${user(uid)}/$_carts/$id';

  static String carts(String uid) => '${user(uid)}/$_carts';

  static String creditCards(String uid) => '${user(uid)}/$_creditCards';

  static String creditCard(String uid, String id) => '${user(uid)}/$_creditCards/$id';
}
