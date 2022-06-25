import 'package:arms/src/features/order/domain/order.dart';
import 'package:arms/src/service/shered_prefs_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../service/firebase/firestore.dart';
import '../../top_level_providers.dart';

class CheckoutRepository {
  CheckoutRepository(this.ref);

  final Ref ref;

  Future<String?> getDefaultAddressId() async {
    return ref.watch(sharedPrefsManagerProvider).getDefaultAddressId();
  }

  Future<void> placeOrder(Order order) async {
    final firebaseUser = ref.watch(authProvider).currentUser;
    final service = ref.read(firestoreServiceProvider);
    await service.writers.set(
      path: FirestorePath.order(firebaseUser!.uid, order.id),
      data: order.toMap(),
    );
  }
}

final checkoutRepositoryProvider = Provider((ref) {
  return CheckoutRepository(ref);
});
