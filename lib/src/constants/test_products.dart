import 'package:arms/src/constants/types.dart';
import 'package:arms/src/features/products/domain/product_option.dart';
import 'package:arms/src/features/products/domain/sku.dart';
import 'package:faker/faker.dart';

import '../features/products/domain/product.dart';

final faker = Faker();

final kTestProducts = List.generate(10, (index) {
  return Product(
      id: index.toString(),
      name: faker.food.dish(),
      description: faker.lorem.sentence(),
      imageUrl: 'non',
      options: options);
});

const options = [
  ProductOption(id: '1', name: 'Size', values: sizeOptionValues),
  ProductOption(id: '2', name: 'Color', values: colorOptionValues),
];

const sizeOptionValues = [
  OptionValue(optionId: '1', id: '1', name: 'S', value: 'S'),
  OptionValue(optionId: '1', id: '2', name: 'M', value: 'M'),
  OptionValue(optionId: '1', id: '3', name: 'L', value: 'L'),
];

const colorOptionValues = [
  OptionValue(optionId: '2', id: '4', name: 'Red', value: 'b1384e'),
  OptionValue(optionId: '2', id: '5', name: 'Blue', value: '9fc9ff'),
  OptionValue(optionId: '2', id: '6', name: 'White', value: 'ffffff'),
];

const image1 = 'https://firebasestorage.googleapis.com/v0/b/fugal-demo.appspot.com/o/avatar_images%2FglNiOca5EMVxB0VCm3FgA7lxAiv1?alt=media&token=f222e7fd-a8b3-4bec-afa7-9836b1441334';
const image2 = 'https://firebasestorage.googleapis.com/v0/b/fugal-demo.appspot.com/o/avatar_images%2FpgoxWdWSNyXaekp9q8TEimWPt5P2?alt=media&token=11b2e772-268e-4977-9e6d-21e35914b7df';
const image3 = 'https://firebasestorage.googleapis.com/v0/b/fugal-demo.appspot.com/o/recipe_images%2Fmabodohu.jpg?alt=media&token=27909e26-b049-4208-b6c5-0d1ddfc3496b';

final kTestSKUs = [
  SKU(
    productId: '1',
    optionValues: [sizeOptionValues[0], colorOptionValues[0]],
    id: '1',
    name: 'SKU_C1S1',
    caption: 'caption',
    description: faker.lorem.sentence(),
    currency: 'JPY',
    price: 1100,
    discount: const Discount(type: DiscountType.none),
    taxRate: 10,
    inventory: 20,
    isAvailable: true,
    tags: [],
    imageUrls: [
      image1,
      image1,
      image1,
      image1,
    ],
  ),
  SKU(
    productId: '1',
    optionValues: [sizeOptionValues[1], colorOptionValues[0]],
    id: '12',
    name: 'SKU_C1S2',
    caption: 'caption',
    description: faker.lorem.sentence(),
    currency: 'JPY',
    price: 1200,
    discount: const Discount(type: DiscountType.none),
    taxRate: 10,
    inventory: 20,
    isAvailable: true,
    tags: [],
    imageUrls: [
      image1,
      image1,
      image1,
      image1,
    ],
  ),
  SKU(
    productId: '1',
    optionValues: [sizeOptionValues[2], colorOptionValues[0]],
    id: '13',
    name: 'SKU_C1S3',
    caption: 'caption',
    description: faker.lorem.sentence(),
    currency: 'JPY',
    price: 1300,
    discount: const Discount(type: DiscountType.none),
    taxRate: 10,
    inventory: 20,
    isAvailable: true,
    tags: [],
    imageUrls: [
      image1,
      image1,
      image1,
      image1,
    ],
  ),

  SKU(
    productId: '1',
    optionValues: [sizeOptionValues[0], colorOptionValues[1]],
    id: '21',
    name: 'SKU_C2S1',
    caption: 'caption',
    description: faker.lorem.sentence(),
    currency: 'JPY',
    price: 2100,
    discount: const Discount(rate: 20),
    taxRate: 10,
    inventory: 20,
    isAvailable: true,
    tags: [],
    imageUrls: [
      image2,
      image2,
      image2,
      image2,
    ],
  ),
  SKU(
    productId: '1',
    optionValues: [sizeOptionValues[1], colorOptionValues[1]],
    id: '22',
    name: 'SKU_C2S2',
    caption: 'caption',
    description: faker.lorem.sentence(),
    currency: 'JPY',
    price: 2200,
    discount: const Discount(rate: 55),
    taxRate: 10,
    inventory: 20,
    isAvailable: true,
    tags: [],
    imageUrls: [
      image2,
      image2,
      image2,
      image2,
    ],
  ),
  SKU(
    productId: '1',
    optionValues: [sizeOptionValues[2], colorOptionValues[1]],
    id: '23',
    name: 'SKU_C2S3',
    caption: 'caption',
    description: faker.lorem.sentence(),
    currency: 'JPY',
    price: 2300,
    discount: const Discount(rate: 22),
    taxRate: 10,
    inventory: 20,
    isAvailable: true,
    tags: [],
    imageUrls: [
      image2,
      image2,
      image2,
      image2,
    ],
  ),

  SKU(
    productId: '1',
    optionValues: [sizeOptionValues[0], colorOptionValues[2]],
    id: '31',
    name: 'SKU_C3S1',
    caption: 'caption',
    description: faker.lorem.sentence(),
    currency: 'JPY',
    price: 3100,
    discount: const Discount(amount: 200, type: DiscountType.absolute),
    taxRate: 10,
    inventory: 20,
    isAvailable: true,
    tags: [],
    imageUrls: [
      image3,
      image3,
      image3,
      image3,
    ],
  ),
  SKU(
    productId: '1',
    optionValues: [sizeOptionValues[1], colorOptionValues[2]],
    id: '32',
    name: 'SKU_C3S2',
    caption: 'caption',
    description: faker.lorem.sentence(),
    currency: 'JPY',
    price: 3200,
    discount: const Discount(amount: 200, type: DiscountType.none),
    taxRate: 10,
    inventory: 20,
    isAvailable: true,
    tags: [],
    imageUrls: [
      image3,
      image3,
      image3,
      image3,
    ],
  ),
  SKU(
    productId: '1',
    optionValues: [sizeOptionValues[2], colorOptionValues[2]],
    id: '33',
    name: 'SKU_C3S3',
    caption: 'caption',
    description: faker.lorem.sentence(),
    currency: 'JPY',
    price: 3300,
    discount: const Discount(rate: 10),
    taxRate: 10,
    inventory: 20,
    isAvailable: true,
    tags: [],
    imageUrls: [
      image3,
      image3,
      image3,
      image3,
    ],
  ),
];


