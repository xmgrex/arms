import 'package:arms/src/common_widget/common_widget.dart';
import 'package:arms/src/features/address/domain/shipping_address.dart';
import 'package:arms/src/features/address/presentation/components/text_input_widget.dart';
import 'package:arms/src/features/address/presentation/edit_address/edit_address_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:x_kit/x_kit.dart';
import '../../../../../generated/l10n.dart';
import '../components/select_state_widget.dart';
import '../components/select_delivery_instruction_widget.dart';

class EditAddressScreen extends ConsumerStatefulWidget {
  const EditAddressScreen({
    Key? key,
    required this.address,
  }) : super(key: key);

  final ShippingAddress address;

  @override
  ConsumerState createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends ConsumerState<EditAddressScreen> {
  @override
  void initState() {
    final notifier =
        ref.read(editAddressScreenControllerProvider(widget.address).notifier);
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
    final controller =
        ref.watch(editAddressScreenControllerProvider(widget.address).notifier);
    final state = ref.watch(editAddressScreenControllerProvider(widget.address));
    final s = S.of(context);
    return LoadingOverlay(
      loadingWidget: const LoadingWidget(),
      isLoading: state.asyncValue.isLoading,
      child: Scaffold(
        appBar: AppBar(
          leading: backPageButton(context: context),
          title: Text(s.editAddress),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextInputWidget(
                label: s.name,
                textEditingController: fullNameController,
              ),
              TextInputWidget(
                label: s.postalCode,
                hint: s.examplePostalCode,
                keyboardType: TextInputType.number,
                textEditingController: postalCodeController,
              ),
              SelectStateWidget(
                initialState: widget.address.state,
                initialCity: widget.address.city,
                onStateChanged: controller.onStateChanged,
                onCityChanged: controller.onCityChanged,
              ),
              TextInputWidget(
                label: s.line1,
                hint: s.exampleLine1,
                textEditingController: line1Controller,
              ),
              TextInputWidget(
                label: s.line2,
                hint: s.exampleLine2,
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
                  label: s.editAddress,
                  radius: Sizes.p4,
                  onPressed: () async {
                    await controller.editShippingAddress().then((_) {
                      context.pop();
                    });
                  },
                ),
              ),
              gapH48,
            ],
          ),
        ),
      ),
    );
  }
}
