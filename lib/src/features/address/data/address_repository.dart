import 'package:arms/src/features/authentication/domain/location.dart';
import 'package:arms/src/service/firebase/firestore.dart';
import 'package:arms/src/service/shered_prefs_manager.dart';
import 'package:firebase_services/firestore_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:geolocator/geolocator.dart';
import 'package:x_kit/x_kit.dart';

import '../../authentication/domain/app_user.dart';
import '../domain/shipping_address.dart';

class AddressRepository {
  AddressRepository(this.sharedPrefsManager, this.service);

  final SharedPrefsManager sharedPrefsManager;
  final FirestoreService service;

  Future<String?> getDefaultAddressId() async {
    return sharedPrefsManager.getDefaultAddressId();
  }

  Future<void> setDefaultAddress(ShippingAddress address) async {
    await sharedPrefsManager.setDefaultAddress(address);
  }

  Future<void> addShippingAddress(AppUser user) async {
    await service.writers.set(
      path: FirestorePath.user(user.uid),
      data: user.toMap(),
    );
  }

  Future<void> editShippingAddress(AppUser appUser) async {
    await service.writers.update(
      path: FirestorePath.user(appUser.uid),
      data: appUser.toMap(),
    );
  }

  Future<ShippingAddress> getCurrentPosition() async {
    final isEnabled = await Geolocator.isLocationServiceEnabled();

    if (!isEnabled) {
      return Future.error('Location services are disabled.');
    }

    final permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      final permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, '
          'we cannot request permissions.');
    }

    final position = await Geolocator.getCurrentPosition();
    final placeMarker = await geocoding.placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    logger.config(placeMarker.toString());
    final shippingAddress = ShippingAddress(
      latitude: position.latitude,
      longitude: position.longitude,
      postalCode: placeMarker.first.postalCode!,
      country: placeMarker.first.country!,
      administrativeArea: placeMarker.first.administrativeArea!,
      locality: placeMarker.first.locality!,
      subLocality: placeMarker.first.subLocality!,
      street: placeMarker.first.street!,
      line1: '',
      line2: '',
      fullName: '',
      instruction: '',
      id: '',
    );
    return shippingAddress;
  }
}

final addressRepositoryProvider = Provider.autoDispose((ref) {
  final sharedPrefsManager = ref.watch(sharedPrefsManagerProvider);
  final firestoreService = ref.watch(firestoreServiceProvider);
  return AddressRepository(sharedPrefsManager, firestoreService);
});
