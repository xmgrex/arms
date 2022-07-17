import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:arms/src/features/top_level_providers.dart';
import 'package:arms/src/service/firebase/firebase_massaging.dart';
import 'package:arms/src/utils/.env.stripe_key.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutterfire_ui/auth.dart';

import 'firebase_options.dart';
import 'src/app/app.dart';
import 'src/constants/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, //縦固定
  ]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Stripe.publishableKey = stripePublishKey;
  FlutterFireUIAuth.configureProviders(Constants.providerConfigs);

  final container = ProviderContainer();
  container.read(authProvider);
  container.read(appUserStateProvider);
  final notification = container.read(notificationServiceProvider);
  await notification.init();
  notification.backgroundMessaging();

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const MyApp(),
    ),
  );
}
