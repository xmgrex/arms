import 'package:arms/src/features/authentication/presentation/account/auth_notifier.dart';
import 'package:arms/src/service/firebase/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_services/firestore_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:x_kit/x_kit.dart';

import '../domain/order.dart';

class OrderRepository {
  OrderRepository(this.service, this.firebaseUser);

  final FirestoreService service;
  final User? firebaseUser;

  Stream<List<Order>> watchOrdersList() {
    return service.streamers.collectionStream(
      path: FirestorePath.orders(firebaseUser!.uid),
      builder: (map, id) {
        return Order.fromMap(map!);
      },
    );
  }
}

final orderRepositoryProvider = Provider((ref) {
  final service = ref.read(firestoreServiceProvider);
  final firebaseUser = ref.watch(firebaseUserNotifierProvider);
  return OrderRepository(service, firebaseUser);
});

final ordersListStreamProvider = StreamProvider<List<Order>>((ref) {
  return ref.watch(orderRepositoryProvider).watchOrdersList();
});
