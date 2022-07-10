import 'package:arms/src/common_widget/loading_widget.dart';
import 'package:arms/src/constants/constants.dart';
import 'package:arms/src/features/address/presentation/add_address/add_address_screeen_controller.dart';
import 'package:arms/src/features/address/presentation/components/text_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:x_kit/x_kit.dart';

import '../../../../../generated/l10n.dart';
import '../../../../common_widget/back_button.dart';
import 'components/preview_map_widget.dart';
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
    final controller= ref.read(addAddressScreenControllerProvider.notifier);
    fullNameController = controller.fullNameController;
    postalCodeController = controller.postalCodeController;
    localityController = controller.localityController;
    subLocalityController = controller.subLocalityController;
    streetController = controller.streetController;
    line1Controller = controller.line1Controller;
    line2Controller = controller.line2Controller;
    controller.getCurrentPosition();

    super.initState();
  }

  late TextEditingController fullNameController;
  late TextEditingController postalCodeController;
  late TextEditingController localityController;
  late TextEditingController subLocalityController;
  late TextEditingController streetController;
  late TextEditingController line1Controller;
  late TextEditingController line2Controller;
  late TextEditingController instructionController;

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(addAddressScreenControllerProvider.notifier);
    final state = ref.watch(addAddressScreenControllerProvider);
    final s = S.of(context);

    // Future(() => controller.getCurrentPosition());
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
    //   await controller.getCurrentPosition();
    // });
    return LoadingOverlay(
      loadingWidget: const LoadingWidget(),
      isLoading: state.asyncValue.isLoading,
      child: Scaffold(
        appBar: AppBar(
          leading: backPageButton(context: context),
          title: Text(s.addAddress, style: TextStyles.title.bold),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: addAddressScreenFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                state.shippingAddress!.latitude != null &&
                        state.shippingAddress!.longitude != null
                    ? PreviewMapWidget(shippingAddress: state.shippingAddress!)
                    : gap0,
                gapH16,
                TextInputWidget(
                  label: s.name,
                  textEditingController: fullNameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return s.nameFromValidator;
                    }
                  },
                ),
                TextInputWidget(
                  label: s.postalCode,
                  hint: s.examplePostalCode,
                  textEditingController: postalCodeController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return s.postalCodeFromValidator;
                    }
                  },
                ),
                TextInputWidget(
                  label: s.locality,
                  hint: s.exampleLocality,
                  textEditingController: localityController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return s.localityFromValidator;
                    }
                  },
                ),
                TextInputWidget(
                  label: s.street,
                  hint: s.exampleStreet,
                  textEditingController: streetController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return s.subLocalityFromValidator;
                    }
                  },
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
                gapH16,
                Padding(
                  padding: const EdgeInsets.all(Sizes.p16),
                  child: ScaleButton(
                    label: s.addAddress,
                    radius: 0.0,
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
      ),
    );
  }
}
