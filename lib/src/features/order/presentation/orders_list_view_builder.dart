import 'package:flutter/material.dart';

import '../domain/order.dart';

class OrdersListViewBuilder extends StatelessWidget {
  const OrdersListViewBuilder({
    Key? key,
    required this.orders,
    required this.itemBuilder,
  }) : super(key: key);

  final List<Order> orders;
  final Function(BuildContext, Order, int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return orders.isEmpty
        ? const Center(child: Text('Order is not found'))
        : ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, i) {
              return itemBuilder(context, orders[i], i);
            },
          );
  }
}
