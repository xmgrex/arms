import 'package:arms/src/features/top_level_providers.dart';
import 'package:arms/src/service/firebase/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_services/firestore_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';

import '../domain/app_user.dart';

/// An in-memory store backed by BehaviorSubject that can be used to
/// store the data for all the fake repositories in the app.
class InMemoryStore<T> {
  InMemoryStore(T initial) : _subject = BehaviorSubject<T>.seeded(initial);

  /// The BehaviorSubject that holds the data
  final BehaviorSubject<T> _subject;

  /// The output stream that can be used to listen to the data
  Stream<T> get stream => _subject.stream;

  /// A synchronous getter for the current value
  T get value => _subject.value;

  /// A setter for updating the value
  set value(T value) => _subject.add(value);

  /// Don't forget to call this when done
  void close() => _subject.close();
}

final authRepositoryProvider = Provider.autoDispose<AuthRepository>((ref) {
  final service = ref.watch(firestoreServiceProvider);
  final firebaseUser = ref.watch(authProvider).currentUser;
  return AuthRepository(service, firebaseUser);
});

class AuthRepository {
  AuthRepository(this.service, this.firebaseUser);

  final FirestoreService service;
  final User? firebaseUser;

  Stream<AppUser> watchCurrentUser(String uid) {
    return service.streamers.documentStream(
      path: FirestorePath.user(uid),
      builder: (map, id) {
        return AppUser.fromMap(map!);
      },
    );
  }

  Future<AppUser> fetchAppUser() async {
    return await service.readers.getDocument(
        path: FirestorePath.user(firebaseUser!.uid),
        builder: (data, _) {
          return AppUser.fromMap(data!);
        });
  }
}

class FakeAuthRepository {
  final _authState = InMemoryStore<AppUser?>(null);

  Stream<AppUser?> authStateChanges() => _authState.stream;

  AppUser? get currentUser => _authState.value;

  Future<void> signOut() async {
    await Future.delayed(const Duration(seconds: 3));
    _authState.value = null;
  }

  void dispose() => _authState.close();
}
