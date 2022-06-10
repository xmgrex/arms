import 'package:arms/src/features/checkout/presentation/checkout_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:x_kit/x_kit.dart';

class CalendarWidget extends ConsumerWidget {
  const CalendarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(checkoutScreenControllerProvider);
    final controller = ref.watch(checkoutScreenControllerProvider.notifier);
    const calendarFormat = CalendarFormat.week;
    final colorScheme = Theme.of(context).colorScheme;

    final todayDecoration = BoxDecoration(
      color: colorScheme.primary.withOpacity(.3),
      shape: BoxShape.circle,
    );
    final selectedDecoration = BoxDecoration(
      color: colorScheme.primary,
      shape: BoxShape.circle,
    );
    final now = DateTime.now();
    var firstDay = now;
    if (now.hour >= 21) {
      firstDay = now.add(const Duration(days: 1));
    }

    return state.deliveryOptions != null
        ? TableCalendar<void>(
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
            ),
            calendarStyle: CalendarStyle(
              selectedTextStyle: TextStyle(color: colorScheme.surface),
              todayDecoration: todayDecoration,
              selectedDecoration: selectedDecoration,
            ),
            locale: 'ja_JP',
            daysOfWeekHeight: 24,
            firstDay: firstDay,
            lastDay: DateTime(now.year, now.month, now.day + 7),
            focusedDay: state.deliveryOptions!.scheduledDeliveryDate.date,
            calendarFormat: calendarFormat,
            selectedDayPredicate: (day) {
              final selectDay =
                  state.deliveryOptions!.scheduledDeliveryDate.date;
              return isSameDay(selectDay, day);
            },
            onDaySelected: (selectedDay, focusDay) {
              controller.selectDate(selectedDay);
            },
          )
        : const SizedBox();
  }
}
