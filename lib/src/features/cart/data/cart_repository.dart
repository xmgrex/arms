import 'package:arms/src/features/authentication/domain/app_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_services/firestore_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../service/firebase/firestore.dart';
import '../../top_level_providers.dart';
import '../domain/cart.dart';

class CartRepository {
  CartRepository(this.service, this.firebaseUser);

  final FirestoreService service;
  final User? firebaseUser;

  Stream<List<CartItem>> watchCartItemsList() {
    return service.streamers.collectionStream(
      path: FirestorePath.carts(firebaseUser!.uid),
      builder: (data, id) {
        return CartItem.fromMap(data!);
      },
    );
  }

  Future<void> addToCart(CartItem cartItem) async {
    await service.writers.set(
      path: FirestorePath.cartItem(firebaseUser!.uid, cartItem.skuId),
      data: cartItem.toMap(),
    );
  }

  Future<void> deleteFromCart(CartItem cartItem) async {
    await service.writers.delete(
      path: FirestorePath.cartItem(firebaseUser!.uid, cartItem.skuId),
    );
  }

  Future<void> updateCart(CartItem cartItem) async {
    await service.writers.update(
      path: FirestorePath.cartItem(firebaseUser!.uid, cartItem.skuId),
      data: cartItem.toMap(),
    );
  }
}

final cartRepositoryProvider = Provider.autoDispose<CartRepository>((ref) {
  final service = ref.watch(firestoreServiceProvider);
  final firebaseUser = ref.watch(authProvider).currentUser;
  return CartRepository(service, firebaseUser);
});

final cartItemsListStreamProvider =
    StreamProvider.autoDispose<List<CartItem>>((ref) {

  final repository = ref.watch(cartRepositoryProvider);
  return repository.watchCartItemsList();
});
