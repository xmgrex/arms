import 'package:arms/src/constants/types.dart';
import 'package:arms/src/features/products/domain/size_option.dart';
import 'package:faker/faker.dart';
import '../features/products/domain/color_option.dart';
import '../features/products/domain/sku.dart';
import '../features/supplier/domain/supplier.dart';

final faker = Faker();

const discountRate10 = Discount(rate: 10);
const discountRate20 = Discount(rate: 20);
const discountAbs200 = Discount(amount: 200, type: DiscountType.absolute);
const discountNone = Discount(type: DiscountType.none);

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
  ColorOption(color: 'Grey', colorCode: '848484'),
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

final kSuppliers = <Supplier>[
  Supplier(
    id: '1',
    name: '１号',
    lat: 34.757914,
    lng: 135.380521,
  ),
  Supplier(
    id: '2',
    name: '２号',
    lat: 34.764095,
    lng: 135.369516,
  ),
  Supplier(
    id: '3',
    name: '３号',
    lat: 34.759544,
    lng: 135.368594,
  ),
];
