import 'package:arms/src/features/checkout/presentation/delivery_option/calendar_widget.dart';
import 'package:arms/src/features/checkout/presentation/delivery_option/delivery_hour_grid_item.dart';
import 'package:arms/src/features/checkout/presentation/delivery_option/delivery_hours_grid_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:x_kit/x_kit.dart';

import '../checkout_screen_controller.dart';
import 'delivery_option_contents.dart';

class DeliveryWindowWidget extends ConsumerWidget {
  const DeliveryWindowWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(checkoutScreenControllerProvider);

    return DeliveryOptionContents(
      title: 'Delivery window',
      contents: Text(
        state.deliveryOptions != null
            ? state.deliveryOptions!.scheduledDeliveryDate.displaySchedule()
            : '',
        style: TextStyles.body.small.bold,
      ),
      onTap: () => showSelectDeliveringWindowModalSheet(context),
    );
  }
}

void showSelectDeliveringWindowModalSheet(BuildContext context) {
  showHalfModalBottomSheet(
    height: MediaQuery.of(context).size.height * .7,
    widget: const Scaffold(
      body: SelectDeliveringWindowModalSheetBodyWidget(),
    ),
    context: context,
  );
}

class SelectDeliveringWindowModalSheetBodyWidget extends ConsumerWidget {
  const SelectDeliveringWindowModalSheetBodyWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(checkoutScreenControllerProvider);
    final controller = ref.watch(checkoutScreenControllerProvider.notifier);
    final colorScheme = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      child: Column(
        children: [
          const CalendarWidget(),
          DeliveryHoursGridBuilder(
            itemBuilder: (_, deliveryTime, index) {
              final now = DateTime.now();
              final scheduledDeliveryDate =
                  state.deliveryOptions!.scheduledDeliveryDate;
              final selectDeliveryTime = scheduledDeliveryDate.deliveryTime;
              final selectDate = scheduledDeliveryDate.date;
              final date = DateTime(
                selectDate.year,
                selectDate.month,
                selectDate.day,
                deliveryTime.hour.round(),
              );
              final isEnabled = date.isAfter(now);
              final isSelected = deliveryTime == selectDeliveryTime;
              return DeliveryHourGridItem(
                onPressed: isEnabled
                    ? () => controller.selectHour(deliveryTime)
                    : null,
                label: deliveryTime.string,
                color: isSelected ? colorScheme.primary : Colors.transparent,
                borderColor: isEnabled
                    ? isSelected
                        ? Colors.transparent
                        : colorScheme.outline
                    : colorScheme.outline.withOpacity(.2),
                textStyle: TextStyle(
                  color: isEnabled
                      ? isSelected
                          ? colorScheme.surface
                          : colorScheme.onSurface
                      : colorScheme.outline.withOpacity(.2),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
