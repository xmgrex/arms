import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FunctionsMethod {
  static const retrievePaymentMethod = 'retrievePaymentMethod';
  static const attachPaymentToCustomer = 'attachPaymentToCustomer';
  static const detachPayment = 'detachPayment';
}

final firebaseFunctionsProvider = Provider((ref) => FirebaseFunctions.instance);