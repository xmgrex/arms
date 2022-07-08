import 'package:arms/src/common_widget/common_widget.dart';
import 'package:arms/src/constants/constants.dart';
import 'package:arms/src/features/products/presentation/product_screen/product_screen_controller.dart';
import 'package:arms/src/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:x_kit/x_kit.dart';

import '../../../../../generated/l10n.dart';
import '../../../products/domain/sku.dart';

var _quantity = 1;

class AddToCartWidget extends ConsumerStatefulWidget {
  const AddToCartWidget({
    Key? key,
    required this.addToCart,
  }) : super(key: key);

  final Function(int) addToCart;

  @override
  ConsumerState createState() => _AddToCartWidgetState();
}

class _AddToCartWidgetState extends ConsumerState<AddToCartWidget> {
  @override
  void initState() {
    _quantity = 1;
    super.initState();
  }

  void showModal(BuildContext context, List<int> items, SKU selectSKU) {
    showHalfModalBottomSheet(
      height: MediaQuery.of(context).size.height * 0.8,
      widget: Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).quantity, style: TextStyles.body.large),
          leading: gap0,
          actions: [
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.close),
            ),
          ],
        ),
        body: SizedBox(
          height: double.infinity,
          child: ListView.separated(
            itemBuilder: (c, index) {
              return RadioListTile(
                title: Text('${items[index]}'),
                value: items[index],
                groupValue: _quantity,
                onChanged: (int? value) {
                  if (selectSKU.inventory >= value!) {
                    setState(() {
                      _quantity = value;
                    });
                  }
                  Navigator.pop(context);
                },
              );
            },
            separatorBuilder: (context, _) => divider(context),
            itemCount: items.length,
          ),
        ),
      ),
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectSKU = ref.watch(productScreenControllerProvider).selectSKU;
    final itemLength = selectSKU!.inventory < 10 ? selectSKU.inventory : 10;
    final items = List.generate(itemLength, (index) => index + 1);
    return Container(
      padding: const EdgeInsets.all(Sizes.p16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(60),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: getProportionateScreenWidth(164),
            child: InkWell(
              onTap: () => showModal(context, items, selectSKU),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${S.of(context).quantity}: $_quantity',
                        style: TextStyles.body.bold,
                      ),
                      const Icon(Icons.arrow_drop_down_sharp)
                    ],
                  ),
                  divider(
                    context,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ],
              ),
            ),
          ),
          gapH32,
          ScaleButton(
            height: Sizes.p48,
            label: S.of(context).addToCart,
            radius: 0,
            onPressed: () {
              widget.addToCart(_quantity);
            },
          ),
          gapH48,
        ],
      ),
    );
  }
}

class _ItemQuantityButton extends StatelessWidget {
  const _ItemQuantityButton({
    Key? key,
    required this.decrement,
    required this.increment,
    required this.quantity,
  }) : super(key: key);

  final VoidCallback decrement;
  final VoidCallback increment;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(Sizes.p4),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceVariant,
          borderRadius: BorderRadius.circular(0),
        ),
        height: Sizes.p48,
        // width: getProportionateScreenWidth(128),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: decrement,
              icon: const Icon(Icons.remove),
            ),
            Text(
              '$quantity',
              style: TextStyles.title.bold,
            ),
            IconButton(
              onPressed: increment,
              icon: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
