import 'package:arms/src/features/address/domain/shipping_address.dart';
import 'package:arms/src/features/authentication/presentation/account/account_info/display_name/edit_display_name_screen.dart';
import 'package:arms/src/features/authentication/presentation/account/account_info/email/edit_email_screen.dart';
import 'package:arms/src/features/authentication/presentation/account/account_info/password/edit_password_screen.dart';
import 'package:arms/src/features/authentication/presentation/sign_in/sign_in_screen.dart';
import 'package:arms/src/features/cart/domain/cart.dart';
import 'package:arms/src/features/checkout/presentation/checkout_screen.dart';
import 'package:arms/src/features/entrypoint/presentation/entrypoint_ui.dart';
import 'package:arms/src/features/payment/presentation/add_credit_card/add_credit_card_screen.dart';
import 'package:arms/src/features/products/domain/product.dart';
import 'package:arms/src/features/products/presentation/product_screen/product_screen.dart';
import 'package:arms/src/features/top_level_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:x_kit/x_kit.dart';

import '../features/address/presentation/add_address/add_address_screen.dart';
import '../features/address/presentation/choose_address/choose_address_screen.dart';
import '../features/address/presentation/edit_address/edit_address_screen.dart';
import '../features/authentication/presentation/account/accessibility/accessibility_settings_screen.dart';
import '../features/authentication/presentation/account/account_info/account_info_screen.dart';
import '../features/payment/presentation/payment_methods/payment_methods_screen.dart';

enum AppRoute {
  entrypoint,
  signIn,
  productScreen,
  checkoutScreen,
  accessibilitySettingsScreen,
  paymentMethodsScreen,
  addCreditCardScreen,
  chooseAddressScreen,
  addAddressScreen,
  editAddressScreen,
  accountInfoScreen,
  editDisplayNameScreen,
  editEmailScreen,
  editPasswordScreen,
}

final goRouterProvider = Provider<GoRouter>((ref) {
  final auth = ref.watch(authProvider);
  return GoRouter(
    debugLogDiagnostics: true,
    redirect: (state) {
      final isLoggedIn = auth.currentUser != null;
      if (!isLoggedIn) {
        return state.subloc == '/signIn' ? null : '/signIn';
      }
      if (state.subloc == '/signIn') {
        return '/';
      }
      return null;
    },
    refreshListenable: GoRouterRefreshStream(auth.authStateChanges()),
    routes: [
      GoRoute(
        path: '/signIn',
        name: AppRoute.signIn.name,
        pageBuilder: (context, state) {
          return MaterialPage(
            key: state.pageKey,
            child: signInScreen,
          );
        },
      ),
      GoRoute(
        path: '/',
        name: AppRoute.entrypoint.name,
        builder: (context, state) => const EntryPointUI(),
        routes: [
          GoRoute(
            path: 'productScreen',
            name: AppRoute.productScreen.name,
            pageBuilder: (context, state) {
              final product = state.extra! as Product;
              return MaterialPage(
                key: state.pageKey,
                child: ProductScreen(product: product),
              );
            },
          ),
          GoRoute(
            path: 'checkoutScreen',
            name: AppRoute.checkoutScreen.name,
            pageBuilder: (context, state) {
              final items = state.extra! as List<CartItem>;
              return MaterialPage(
                key: state.pageKey,
                child: CheckoutScreen(items: items),
              );
            },
          ),
          GoRoute(
            path: 'accessibilitySettingsScreen',
            name: AppRoute.accessibilitySettingsScreen.name,
            pageBuilder: (context, state) {
              return MaterialPage(
                key: state.pageKey,
                child: const AccessibilitySettingsScreen(),
              );
            },
          ),
          GoRoute(
            path: 'paymentMethodsScreen',
            name: AppRoute.paymentMethodsScreen.name,
            pageBuilder: (context, state) {
              return MaterialPage(
                key: state.pageKey,
                child: const PaymentMethodsScreen(),
              );
            },
            routes: [
              GoRoute(
                path: 'addCreditCardScreen',
                name: AppRoute.addCreditCardScreen.name,
                pageBuilder: (context, state) {
                  return MaterialPage(
                    key: state.pageKey,
                    child: const AddCreditCardScreen(),
                  );
                },
              ),
            ]
          ),
          GoRoute(
            path: 'chooseAddressScreen',
            name: AppRoute.chooseAddressScreen.name,
            pageBuilder: (context, state) {
              return MaterialPage(
                key: state.pageKey,
                child: const ChooseAddressScreen(),
              );
            },
              routes: [
                GoRoute(
                  path: 'addAddressScreen',
                  name: AppRoute.addAddressScreen.name,
                  pageBuilder: (context, state) {
                    return MaterialPage(
                      key: state.pageKey,
                      child: const AddAddressScreen(),
                    );
                  },
                ),
                GoRoute(
                  path: 'editAddressScreen',
                  name: AppRoute.editAddressScreen.name,
                  pageBuilder: (context, state) {
                    final address = state.extra as ShippingAddress;
                    return MaterialPage(
                      key: state.pageKey,
                      child: EditAddressScreen(address: address),
                    );
                  },
                ),
              ]
          ),
          GoRoute(
            path: 'accountInfoScreen',
            name: AppRoute.accountInfoScreen.name,
            pageBuilder: (context, state) {
              return MaterialPage(
                key: state.pageKey,
                child: const AccountInfoScreen(),
              );
            },
            routes: [
              GoRoute(
                path: 'editDisplayNameScreen',
                name: AppRoute.editDisplayNameScreen.name,
                pageBuilder: (context, state) {
                  return MaterialPage(
                    key: state.pageKey,
                    child: const EditDisplayNameScreen(),
                  );
                },
              ),
              GoRoute(
                path: 'editEmailScreen',
                name: AppRoute.editEmailScreen.name,
                pageBuilder: (context, state) {
                  return MaterialPage(
                    key: state.pageKey,
                    child: const EditEmailScreen(),
                  );
                },
              ),
              GoRoute(
                path: 'editPasswordScreen',
                name: AppRoute.editPasswordScreen.name,
                pageBuilder: (context, state) {
                  return MaterialPage(
                    key: state.pageKey,
                    child: const EditPasswordScreen(),
                  );
                },
              ),
            ]
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) {
      // logger.info(state.error.toString());
      return const NotFoundScreen();
    },
  );
});
