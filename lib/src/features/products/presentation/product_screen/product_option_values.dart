import 'package:arms/src/features/products/domain/product_option.dart';
import 'package:arms/src/features/products/presentation/product_screen/porduct_screen_controller.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:x_kit/x_kit.dart';

Future<void> showSelectOptionValueModalSheet(
    BuildContext context, ProductOption option) async {
  await showHalfModalBottomSheet(
    height: MediaQuery.of(context).size.height / 2,
    widget: ProductOptionValues(option: option),
    context: context,
  );
}

class ProductOptionValues extends ConsumerWidget {
  const ProductOptionValues({
    Key? key,
    required this.option,
  }) : super(key: key);

  final ProductOption option;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close),
        ),
        title: Text('Select ${option.name}'),
      ),
      body: ListView.separated(
        shrinkWrap: true,
        itemCount: option.values.length,
        itemBuilder: (_, int i) {
          Widget widget = Container();
          switch (option.name) {
            case 'Size':
              widget = SizeOptionValueItem(value: option.values[i]);
              break;
            case 'Color':
              widget = ColorOptionValueItem(value: option.values[i]);
              break;
          }
          return widget;
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            height: 1,
            color: Theme.of(context).colorScheme.onSurface,
          );
        },
      ),
    );
  }
}

class ColorOptionValueItem extends ConsumerWidget {
  const ColorOptionValueItem({
    Key? key,
    required this.value,
  }) : super(key: key);

  final OptionValue value;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(productScreenControllerProvider);
    final color = value.value.toColor;
    return ListTile(
      trailing: Icon(
        Icons.circle,
        size: Sizes.p16,
        color: state.selectedOptionValuesList.contains(value)
            ? Theme.of(context).colorScheme.primary
            : Colors.transparent,
      ),
      onTap: () {
        final notifier = ref.read(productScreenControllerProvider.notifier);
        notifier.selectOptionValue(value);
        Navigator.pop(context);
      },
      title: Row(
        children: [
          Container(
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            height: 32.0,
            width: 32.0,
          ),
          gapW8,
          Text(
            value.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyles.title,
          ),
        ],
      ),
    );
  }
}

class SizeOptionValueItem extends ConsumerWidget {
  const SizeOptionValueItem({
    Key? key,
    required this.value,
  }) : super(key: key);

  final OptionValue value;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(productScreenControllerProvider);
    return ListTile(
      trailing: Icon(
        Icons.circle,
        size: Sizes.p16,
        color: state.selectedOptionValuesList.contains(value)
            ? Theme.of(context).colorScheme.primary
            : Colors.transparent,
      ),
      selectedColor: Theme.of(context).colorScheme.onTertiary,
      onTap: () {
        final notifier = ref.read(productScreenControllerProvider.notifier);
        notifier.selectOptionValue(value);
        Navigator.pop(context);
      },
      title: Text(
        value.name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyles.title,
      ),
    );
  }
}
