import 'package:arms/src/common_widget/loading_widget.dart';
import 'package:arms/src/features/address/presentation/add_address/add_address_screeen_controller.dart';
import 'package:arms/src/features/address/presentation/components/text_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:x_kit/x_kit.dart';

import '../../../../common_widget/back_button.dart';
import '../components/select_state_widget.dart';
import '../components/select_delivery_instruction_widget.dart';

class AddAddressScreen extends ConsumerStatefulWidget {
  const AddAddressScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends ConsumerState<AddAddressScreen> {
  @override
  void initState() {
    final notifier = ref.read(addAddressScreenControllerProvider.notifier);
    fullNameController = notifier.fullNameController;
    postalCodeController = notifier.postalCodeController;
    line1Controller = notifier.line1Controller;
    line2Controller = notifier.line2Controller;

    super.initState();
  }

  late TextEditingController fullNameController;
  late TextEditingController postalCodeController;
  late TextEditingController line1Controller;
  late TextEditingController line2Controller;
  late TextEditingController instructionController;

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(addAddressScreenControllerProvider.notifier);
    final state = ref.watch(addAddressScreenControllerProvider);
    return LoadingOverlay(
      loadingWidget: const LoadingWidget(),
      isLoading: state.asyncValue.isLoading,
      child: Scaffold(
        appBar: AppBar(
          leading: backPageButton(context: context),
          title: const Text('Add address'),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextInputWidget(
                label: '氏名',
                textEditingController: fullNameController,
              ),
              TextInputWidget(
                label: 'Postal code',
                hint: 'example: 6610045',
                keyboardType: TextInputType.number,
                textEditingController: postalCodeController,
              ),
              SelectStateWidget(
                onStateChanged: controller.onStateChanged,
                onCityChanged: controller.onCityChanged,
              ),
              TextInputWidget(
                label: 'Line1',
                hint: 'example: line1',
                textEditingController: line1Controller,
              ),
              TextInputWidget(
                label: 'Line2',
                hint: 'example: line2',
                textEditingController: line2Controller,
              ),
              SelectDeliveryInstructionWidget(
                selectInstruction: controller.instruction,
                onChanged: (value) {
                  controller.onDeliveryInstructionChanged(value!);
                },
              ),
              gapH24,
              Padding(
                padding: const EdgeInsets.all(Sizes.p16),
                child: ScaleButton(
                  label: 'Add address',
                  radius: Sizes.p4,
                  onPressed: () async {
                    final controller =
                        ref.read(addAddressScreenControllerProvider.notifier);
                    await controller.addShippingAddress().then((_) {
                      context.pop();
                    });
                  },
                ),
              ),
              gapH32,
            ],
          ),
        ),
      ),
    );
  }
}
