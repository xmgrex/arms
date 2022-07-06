
import 'package:arms/src/common_widget/common_widget.dart';
import 'package:arms/src/features/top_level_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:x_kit/x_kit.dart';

import '../checkout_screen_controller.dart';
import 'delivering_to_widget.dart';
import 'delivery_instructions_widget.dart';
import 'delivery_window_widget.dart';

class DeliveryOptionsWidget extends ConsumerWidget {
  const DeliveryOptionsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Delivery options', style: TextStyles.title.bold),
          const DeliveringToWidget(),
          divider(context),
          const DeliveryInstructionsWidget(),
          divider(context),
          const DeliveryWindowWidget()
        ],
      ),
    );
  }
}
