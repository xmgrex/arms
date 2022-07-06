import 'package:arms/src/common_widget/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:x_kit/x_kit.dart';

import '../data/order_repository.dart';
import '../domain/order.dart';
import 'order_list_tile.dart';
import 'orders_list_view_builder.dart';

class OrdersListPage extends ConsumerWidget {
  const OrdersListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ordersListValue = ref.watch(ordersListStreamProvider);
    return Scaffold(
      appBar: AppBar(title: Text('Orders', style: TextStyles.title.bold)),
      body: AsyncValueWidget<List<Order>>(
        value: ordersListValue,
        data: (ordersList) {
          return OrdersListViewBuilder(
            orders: ordersList,
            itemBuilder: (_, order, index) {
              return OrderListTile(order: order);
            },
          );
        },
      ),
    );
  }
}
