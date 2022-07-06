import 'package:arms/src/features/address/domain/shipping_address.dart';
import 'package:arms/src/routing/app_router.dart';
import 'package:arms/src/utils/super_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';

class ChooseAddressListTile extends StatelessWidget {
  const ChooseAddressListTile({
    Key? key,
    required this.address,
    required this.defaultAddressId,
    required this.onChanged,
    this.secondary,
  }) : super(key: key);

  final ShippingAddress address;
  final String? defaultAddressId;
  final ValueChanged<String?> onChanged;
  final Widget? secondary;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        extentRatio: .3,
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            borderRadius: BorderRadius.circular(8.0),
            onPressed: (context) {},
            label: 'Delete',
            backgroundColor: Colors.redAccent.withOpacity(.8),
            // foregroundColor: colorScheme.error,
          ),
        ],
      ),
      child: RadioListTile<String>(
        title: Text(address.displayAddress()),
        subtitle: Text('${address.fullName}, ${address.postalCode}'),
        secondary: secondary ?? TextButton(
          onPressed: () {
            context.goNamed(AppRoute.editAddressScreen.name, extra: address);
          },
          child: const Text('Edit'),
        ),
        value: address.id,
        groupValue: defaultAddressId,
        onChanged: onChanged,
      ),
    );
  }
}
