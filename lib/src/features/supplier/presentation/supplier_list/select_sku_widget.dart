import 'package:arms/generated/l10n.dart';
import 'package:arms/src/constants/constants.dart';
import 'package:arms/src/features/products/domain/sku.dart';
import 'package:flutter/material.dart';
import 'package:x_kit/x_kit.dart';

class SelectSKU extends StatelessWidget {
  const SelectSKU({Key? key, required this.sku}) : super(key: key);

  final SKU sku;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                sku.imageUrls.first,
                height: 128.0,
                width: 128.0,
              ), // Todo
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      sku.name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyles.body.bold,
                    ),
                    gapH8,
                    sku.size == null
                        ? gap0
                        : Text('${S.of(context).size}： ${sku.size!.value}'),
                    sku.color == null
                        ? gap0
                        : Text('${S.of(context).color}： ${sku.color!.color}'),
                  ],
                ),
              )
            ],
          ),
        ),
        const Divider(thickness: 3),
      ],
    );
  }
}
