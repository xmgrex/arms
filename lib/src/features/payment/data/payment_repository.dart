import 'package:arms/src/features/payment/domain/credit_card.dart';
import 'package:arms/src/features/top_level_providers.dart';
import 'package:arms/src/service/firebase/firestore.dart';
import 'package:arms/src/service/firebase/firebase_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_services/firestore_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:x_kit/x_kit.dart';

class PaymentRepository {
  PaymentRepository(this.service, this.firebaseUser, this.functions);

  final FirestoreService service;
  final User? firebaseUser;
  final FirebaseFunctions functions;

  Stream<List<CreditCard>> watchCreditCards() {
    return service.streamers.collectionStream(
      path: FirestorePath.creditCards(firebaseUser!.uid),
      builder: (data, id) {
        return CreditCard.fromMap(data!);
      },
    );
  }

  Future<void> addCreditCard() async {
    final billingDetails = BillingDetails(email: firebaseUser!.email);
    final paymentMethod = await Stripe.instance.createPaymentMethod(
      PaymentMethodParams.card(
        paymentMethodData: PaymentMethodData(billingDetails: billingDetails),
      ),
    );
    final result = await functions
        .httpsCallable(FunctionsMethod.retrievePaymentMethod)
        .call<Map<String, dynamic>>(
      {'paymentMethodId': paymentMethod.id},
    );
    final creditCard = CreditCard.fromJson(result.data);

    final creditCardsPath = FirestorePath.creditCards(
      firebaseUser!.uid,
    );
    final fingerprints = await service.readers.getCollection(
      path: creditCardsPath,
      builder: (data, _) => CreditCard.fromMap(data!).fingerprint,
    );
    if (!fingerprints.contains(creditCard.fingerprint)) {
      final creditCardPath = FirestorePath.creditCard(
        firebaseUser!.uid,
        creditCard.id,
      );
      await service.writers.set(path: creditCardPath, data: creditCard.toMap());
    }
  }

  Future<void> setDefaultCreditCard(CreditCard creditCard) async {
    final userPath = FirestorePath.user(firebaseUser!.uid);
    final customerPath = FirestorePath.customer(firebaseUser!.uid);
    await service.firestoreInstance.runTransaction((transaction) async {
      final userRef = service.firestoreInstance.doc(userPath);
      final customerRef = service.firestoreInstance.doc(customerPath);
      final customer = await transaction.get(customerRef);
      transaction.update(userRef, {'defaultCard': creditCard.toMap()});
      await functions
          .httpsCallable(FunctionsMethod.attachPaymentToCustomer)
          .call<Map<String, dynamic>>(
        {
          'paymentMethodId': creditCard.id,
          'customerId': customer.data()!['customerId'],
        },
      );
    });
  }

  Future<void> deleteCreditCard(CreditCard creditCard, bool isDefault) async {
    final userPath = FirestorePath.user(firebaseUser!.uid);
    final creditCardPath = FirestorePath.creditCard(
      firebaseUser!.uid,
      creditCard.id,
    );
    final batch = service.firestoreInstance.batch();
    batch.delete(service.firestoreInstance.doc(creditCardPath));
    if (isDefault) {
      batch.update(
        service.firestoreInstance.doc(userPath),
        {'defaultCard': null},
      );
    }
    await functions
        .httpsCallable(FunctionsMethod.detachPayment)
        .call<Map<String, dynamic>>(
      {'paymentMethodId': creditCard.id},
    );
    await batch.commit();
  }
}

final paymentRepositoryProvider = Provider.autoDispose((ref) {
  final service = ref.watch(firestoreServiceProvider);
  final firebaseUser = ref.watch(authProvider).currentUser;
  final functions = ref.watch(firebaseFunctionsProvider);
  return PaymentRepository(service, firebaseUser, functions);
});

final creditCardsStreamProvider =
    StreamProvider.autoDispose<List<CreditCard>>((ref) {
  final paymentRepository = ref.watch(paymentRepositoryProvider);
  return paymentRepository.watchCreditCards();
});
