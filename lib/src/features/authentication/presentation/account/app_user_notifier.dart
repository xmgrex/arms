import 'package:arms/src/features/authentication/data/auth_repository.dart';
import 'package:arms/src/features/authentication/domain/app_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:x_kit/x_kit.dart';

import '../../../top_level_providers.dart';

class AppUserNotifier extends StateNotifier<AppUser?> {
  AppUserNotifier(this._read) : super(null) {
    _auth.userChanges().listen((firebaseUser) {
      _read(authRepositoryProvider)
          .watchCurrentUser(firebaseUser!.uid)
          .listen((user) {
            logger.config(user.toString());
        state = user;
      });
    });
  }

  final _auth = FirebaseAuth.instance;
  final Reader _read;
}
