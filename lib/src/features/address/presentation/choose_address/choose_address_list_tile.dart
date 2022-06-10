import 'package:arms/src/features/address/domain/shipping_address.dart';
import 'package:arms/src/routing/app_router.dart';
import 'package:flutter/material.dart';
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
    return RadioListTile<String>(
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
    );
  }
}
