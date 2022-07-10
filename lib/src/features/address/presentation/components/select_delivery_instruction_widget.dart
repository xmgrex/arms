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
    // final controller = OverrideExpandableController.instance;
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        gapH8,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text('配達指定', style: TextStyles.title),
        ),
        SizedBox(
          height: 48,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            scrollDirection: Axis.horizontal,
            children: [
              ...DeliveryInstruction.values.map((e) {
                final selected = selectInstruction == e;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3.0),
                  child: ChoiceChip(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(60.0)),
                    label: Text(displayDeliveryInstruction(e)),
                    labelStyle: TextStyles.body.copyWith(
                      color: selected
                          ? colorScheme.background
                          : colorScheme.onBackground,
                    ),
                    labelPadding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 2.0,
                    ),
                    backgroundColor: colorScheme.outline.withOpacity(.18),
                    selectedColor: colorScheme.onBackground,
                    selected: selected,
                    onSelected: (selected) {
                      onChanged!(e);
                    },
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ],
    );
    //   Padding(
    //   padding: const EdgeInsets.all(Sizes.p16),
    //   child: Expandable(
    //     color: colorScheme.outline.withOpacity(.18),
    //     isExpand: true,
    //     expandableController: controller,
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(Sizes.p4),
    //     ),
    //     iconColor: colorScheme.onSurface,
    //     header: const Padding(
    //       padding: EdgeInsets.all(Sizes.p16),
    //       child: Text('置き配指定'),
    //     ),
    //     child: Column(
    //       children: DeliveryInstruction.values.map((e) {
    //         return RadioListTile<DeliveryInstruction>(
    //           title: Text(displayDeliveryInstruction(e)),
    //           value: e,
    //           groupValue: selectInstruction,
    //           onChanged: onChanged,
    //         );
    //       }).toList(),
    //     ),
    //   ),
    // );
  }
}
