import 'package:arms/src/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:x_kit/x_kit.dart';

import '../../../../../../generated/l10n.dart';
import '../product_screen_controller.dart';

class SelectSupplierWidget extends ConsumerWidget {
  const SelectSupplierWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(productScreenControllerProvider);
    return state.selectSupplier == null
        ? gap0
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              gapH8,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(state.selectSupplier!.id),
              ),
              state.selectSKU!.inventory > 0
                  ? ListTile(
                      leading: const Icon(
                        Icons.circle_outlined,
                        color: Colors.greenAccent,
                      ),
                      title: Text(S.of(context).inStock),
                    )
                  : ListTile(
                      leading: Icon(
                        Icons.close,
                        color: Theme.of(context).colorScheme.error,
                      ),
                      title: Text(S.of(context).noStock),
                    ),
              const Divider(),
              ListTile(
                leading:
                    SvgPicture.asset('assets/icons/container_car_icon.svg'),
                title: Text(S.of(context).checkOurInventoryOfOtherCars),
                trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
              ),
              const Divider(),
            ],
          );
  }
}
