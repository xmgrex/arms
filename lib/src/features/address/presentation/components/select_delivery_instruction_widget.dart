import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:x_kit/x_kit.dart';
import '../../domain/shipping_address.dart';

class SelectDeliveryInstructionWidget extends ConsumerWidget {
  const SelectDeliveryInstructionWidget({
    Key? key,
    required this.selectInstruction,
    required this.onChanged,
  }) : super(key: key);

  final DeliveryInstruction selectInstruction;
  final ValueChanged<DeliveryInstruction?>? onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = OverrideExpandableController.instance;
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(Sizes.p16),
      child: Expandable(
        isExpand: true,
        expandableController: controller,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: colorScheme.onSurface.withOpacity(.4),
          ),
          borderRadius: BorderRadius.circular(Sizes.p4),
        ),
        iconColor: colorScheme.onSurface,
        header: const Padding(
          padding: EdgeInsets.all(Sizes.p16),
          child: Text('置き配指定'),
        ),
        child: Column(
          children: DeliveryInstruction.values.map((e) {
            return RadioListTile<DeliveryInstruction>(
              title: Text(displayDeliveryInstruction(e)),
              value: e,
              groupValue: selectInstruction,
              onChanged: onChanged,
            );
          }).toList(),
        ),
      ),
    );
  }
}
