import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:x_kit/x_kit.dart';

import '../../../../../generated/l10n.dart';

const double defaultPadding = 16;

class EmptyCartScreen extends StatelessWidget {
  const EmptyCartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              SvgPicture.asset(
                'assets/icons/shopping-cart.svg',
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.height * 0.2,
              ),
              // Image.asset('assets/icons/shopping-cart.svg'),
              // const SizedBox(height: defaultPadding * 2),
              // Text(
              //   "Buy some stuff :)",
              //   style: Theme.of(context).textTheme.headline6,
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: defaultPadding * 2,
                  vertical: defaultPadding,
                ),
                child: Text(
                  S.of(context).cartIsEmpty,
                  textAlign: TextAlign.center,
                  style: TextStyles.title,
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
