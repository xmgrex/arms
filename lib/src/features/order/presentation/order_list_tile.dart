import 'package:arms/src/features/order/domain/order.dart';
import 'package:flutter/material.dart';
import 'package:x_kit/x_kit.dart';

class OrderListTile extends StatelessWidget {
  const OrderListTile({Key? key, required this.order}) : super(key: key);

  final Order order;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      leading: ImageFromUrl(imageUrl: order.items.first.imageUrls.first),
      title: Text(order.items.first.name, style: TextStyles.body.bold,),
      subtitle: Text(
          '${order.items.length}items・Arriving ${order.deliveryOptions.scheduledDeliveryDate.displaySchedule()}'),
    );
  }
}
