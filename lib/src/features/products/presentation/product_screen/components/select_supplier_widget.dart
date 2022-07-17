import 'package:arms/src/constants/constants.dart';
import 'package:arms/src/features/products/domain/sku.dart';
import 'package:arms/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:x_kit/x_kit.dart';

import '../../../../../../generated/l10n.dart';
import '../product_screen_controller.dart';

class SelectSupplierWidget extends ConsumerWidget {
  const SelectSupplierWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectSKU = ref.watch(
        productScreenControllerProvider.select((state) => state.selectSKU));
    final selectSupplier = ref.watch(productScreenControllerProvider
        .select((state) => state.selectSupplier));
    final suppliers = ref.watch(productScreenControllerProvider
        .select((state) => state.suppliers));
    return selectSupplier == null
        ? gap0
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              gapH8,
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Text(
                  S.of(context).inventoryStatus,
                  style: TextStyles.title.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(selectSupplier.name),
              ),
              _inventoryStatusWidget(context, selectSKU!),
              const Divider(),
              ListTile(
                onTap: () {
                  context.pushNamed(
                    AppRoute.nearBySupplierListScreen.name,
                    extra: {
                      'suppliers': suppliers!,
                      'sku': selectSKU,
                    },
                  );
                },
                leading: SvgPicture.asset(
                  'assets/icons/container_car_icon.svg',
                ),
                minLeadingWidth: 24,
                title: Text(
                  S.of(context).checkOurInventoryOfOtherCars,
                  style: TextStyles.body,
                ),
                trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
              ),
              const Divider(),
            ],
          );
  }

  Widget _inventoryStatusWidget(BuildContext context, SKU selectSKU) {
    final isStock = selectSKU.inventory > 0;
    final icon = isStock
        ? const Icon(
            Icons.circle_outlined,
            color: Colors.greenAccent,
          )
        : Icon(
            Icons.close,
            color: Theme.of(context).colorScheme.error,
          );
    final title = isStock ? S.of(context).inStock : S.of(context).noStock;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: [
          icon,
          gapW8,
          Text(title, style: TextStyles.body),
        ],
      ),
    );
  }
}
