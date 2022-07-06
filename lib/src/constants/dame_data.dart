import 'package:arms/src/constants/types.dart';
import 'package:arms/src/features/products/domain/size_option.dart';
import 'package:faker/faker.dart';
import '../features/products/domain/color_option.dart';
import '../features/products/domain/sku.dart';

final faker = Faker();

const discountRate10 = Discount(rate: 10);
const discountRate20 = Discount(rate: 20);
const discountAbs200 = Discount(amount: 200, type: DiscountType.absolute);
const discountNone = Discount(type: DiscountType.none);

const options = [
  {
    'colors': colorOptionValues,
  },
  {
    'size': sizeOptionValues,
  },
  // ProductOption(id: 'Color', type: OptionType.color, values: colorOptionValues),
];

const sizeOptionValues = [
  SizeOption(size: 'S', value: 'S'),
  SizeOption(size: 'M', value: 'M'),
  SizeOption(size: 'L', value: 'L'),
  SizeOption(size: 'XL', value: 'XL'),
];

const colorOptionValues = [
  ColorOption(color: 'Black', colorCode: '212121'),
  ColorOption(color: 'Blue', colorCode: '9fc9ff'),
  ColorOption(color: 'White', colorCode: 'FFFFFF'),
  ColorOption(color: 'Red', colorCode: 'F6625E'),
];

SKU createSKU(
  String productId,
  String name,
  double price,
  List<String> images,
  String id,
  Discount discount, {
  int? inventory,
  ColorOption? colorOption,
  SizeOption? sizeOption,
}) {
  return SKU(
    productId: productId,
    id: id,
    name: name,
    caption: 'caption',
    description: faker.lorem.sentence(),
    currency: 'JPY',
    price: price,
    discount: discount,
    taxRate: 10,
    inventory: inventory ?? 20,
    isAvailable: true,
    tags: [],
    imageUrls: images,
    color: colorOption,
    size: sizeOption,
  );
}
