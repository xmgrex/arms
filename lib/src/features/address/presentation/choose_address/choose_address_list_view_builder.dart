import 'package:arms/src/features/address/domain/shipping_address.dart';
import 'package:flutter/material.dart';
import 'package:x_kit/x_kit.dart';

class ChooseAddressListViewBuilder extends StatelessWidget {
  const ChooseAddressListViewBuilder({
    Key? key,
    required this.addresses,
    required this.itemBuilder,
  }) : super(key: key);

  final List<ShippingAddress> addresses;
  final Widget Function(BuildContext, ShippingAddress, int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    if (addresses.isEmpty) {
      const Padding(
        padding: EdgeInsets.all(Sizes.p16),
        child: SizedBox(
          child: Text('Non address'),
        ),
      );
    }
    return Scrollbar(
      child: ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        itemCount: addresses.length,
        itemBuilder: (context, index) {
          return itemBuilder(context, addresses[index], index);
        },
      ),
    );
  }
}
