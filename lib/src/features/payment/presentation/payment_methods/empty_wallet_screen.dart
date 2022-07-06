import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:x_kit/x_kit.dart';

import '../../../../routing/app_router.dart';

const double defaultPadding = 16;

class EmptyWalletScreen extends StatelessWidget {
  const EmptyWalletScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 40),
                  Column(
                    children: [
                      Text(
                        "Wallet".toUpperCase(),
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      const SizedBox(height: defaultPadding / 2),
                      const Text(
                        "Your payment methods will \nappear here",
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                  SizedBox(
                    width: 40,
                    child: TextButton(
                      onPressed: () {
                        context.pushNamed(AppRoute.addCreditCardScreen.name);
                      },
                      child: const Icon(XIcons.add)
                    ),
                  )
                ],
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.75,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  SvgPicture.asset(
                    "assets/illestrations/empty_wallet_3.svg",
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.height * 0.7,
                  ),
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.white,
                          Colors.white.withOpacity(0),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
