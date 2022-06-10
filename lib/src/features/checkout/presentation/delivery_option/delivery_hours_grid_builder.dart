import 'package:arms/src/constants/constants.dart';
import 'package:flutter/material.dart';
import '../../domain/scheduled_delivery_date.dart';

class DeliveryHoursGridBuilder extends StatelessWidget {
  const DeliveryHoursGridBuilder({
    Key? key,
    required this.itemBuilder,
  }) : super(key: key);

  final Widget Function(BuildContext, DeliveryTime, int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 6),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 2.7,
        crossAxisSpacing: 6,
        mainAxisSpacing: 12,
      ),
      itemCount: Constants.deliveryTimes.length,
      itemBuilder: (context, int i) {
        return itemBuilder(context, Constants.deliveryTimes[i], i);
      },
    );
  }
}
