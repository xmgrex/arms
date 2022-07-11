import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:x_kit/x_kit.dart';

import '../../../../../generated/l10n.dart';
import '../../../address/domain/shipping_address.dart';
import '../checkout_screen_controller.dart';
import 'delivery_option_contents.dart';

class DeliveryInstructionsWidget extends ConsumerWidget {
  const DeliveryInstructionsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(checkoutScreenControllerProvider);

    return DeliveryOptionContents(
      onTap: () {
        showSelectDeliveryInstructionModalSheet(context);
      },
      title: S.of(context).deliveryInstructions,
      contents: state.deliveryOptions == null ||
              state.deliveryOptions!.address.instruction.isEmpty
          ? Text(
        S.of(context).noDeliveryInstructions,
              style: TextStyles.body.large.grey,
            )
          : Text(
              state.deliveryOptions!.address.instruction,
              style: TextStyles.body.small.bold,
            ),
    );
  }
}

void showSelectDeliveryInstructionModalSheet(BuildContext context) {
  showHalfModalBottomSheet(
    height: MediaQuery.of(context).size.height * .5,
    widget: Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).deliveryInstructions),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: const SelectDeliveryInstructionModalSheetBodyWidget(),
    ),
    context: context,
  );
}

class SelectDeliveryInstructionModalSheetBodyWidget extends ConsumerWidget {
  const SelectDeliveryInstructionModalSheetBodyWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(checkoutScreenControllerProvider);
    final controller = ref.watch(checkoutScreenControllerProvider.notifier);
    final instruction = state.deliveryOptions!.address.instruction;

    return Scrollbar(
      trackVisibility: true,
      child: ListView(
        children: DeliveryInstruction.values.map((e) {
          return RadioListTile<DeliveryInstruction>(
            title: Text(displayDeliveryInstruction(e)),
            value: e,
            groupValue: state.deliveryOptions != null
                ? convertToDeliveryInstruction(instruction)
                : DeliveryInstruction.noSetup,
            onChanged: controller.selectDeliveryInstruction,
          );
        }).toList(),
      ),
    );
  }
}
