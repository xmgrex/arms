import 'package:arms/generated/l10n.dart';
import 'package:arms/src/features/supplier/domain/supplier.dart';
import 'package:flutter/material.dart';
import 'package:x_kit/x_kit.dart';

class SupplierListBuilder extends StatelessWidget {
  const SupplierListBuilder(
      {Key? key, required this.suppliers, required this.builder})
      : super(key: key);

  final List<Supplier> suppliers;
  final Function(BuildContext, int, Supplier) builder;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(S.of(context).carList, style: TextStyles.body.bold),
        ),
        const Divider(indent: 16.0, endIndent: 16.0),
        gapH8,
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: suppliers.length,
          itemBuilder: (context, i) {
            return builder(context, i, suppliers[i]);
          },
          // separatorBuilder: (_, i) {
          //   return const Divider(indent: 16.0, endIndent: 16.0);
          // },
        ),
      ],
    );
  }
}
