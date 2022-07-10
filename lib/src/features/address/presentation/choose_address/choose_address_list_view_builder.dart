import 'package:arms/src/common_widget/common_widget.dart';
import 'package:arms/src/features/address/domain/shipping_address.dart';
import 'package:flutter/material.dart';
import 'package:x_kit/x_kit.dart';

import '../../../../constants/constants.dart';

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
      child: ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        itemCount: addresses.length,
        itemBuilder: (context, index) {
          return itemBuilder(context, addresses[index], index);
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(indent: indent, endIndent: indent);
        },
      ),
    );
  }
}
