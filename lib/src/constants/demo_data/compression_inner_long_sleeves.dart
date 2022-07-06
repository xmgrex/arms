import '../../features/products/domain/product.dart';
import '../dame_data.dart';

const _innerS = 'N-i-C-non-S-S';
const _innerM = 'N-i-C-non-S-M';
const _innerL = 'N-i-C-non-S-L';
const _innerXL = 'N-i-C-non-S-XL';

const _innerImages = [
  "assets/images/Compression_inner_long_sleeves1.jpeg",
];

const _name = 'UNDER ARMOUR Compression inner long sleeves';
const _price = 2759.0;
const _productId = 'Compression inner long sleeves';

final kCompressionInnerLongSleeves = Product(
  id: _productId,
  name: _name,
  description: faker.lorem.sentence(),
  imageUrl: _innerImages[0],
  price: _price,
  sizes: sizeOptionValues,
);

final kCompressionInnerLongSleevesList = [
  createSKU(
    _productId,
    _name,
    _price,
    _innerImages,
    _innerS,
    discountAbs200,
    inventory: 0,
    sizeOption: sizeOptionValues[0],
  ),
  createSKU(
    _productId,
    _name,
    _price,
    _innerImages,
    _innerM,
    discountAbs200,
    inventory: 0,
    sizeOption: sizeOptionValues[1],
  ),
  createSKU(
    _productId,
    _name,
    _price,
    _innerImages,
    _innerL,
    discountAbs200,
    sizeOption: sizeOptionValues[2],
  ),
  createSKU(
    _productId,
    _name,
    _price,
    _innerImages,
    _innerXL,
    discountAbs200,
    sizeOption: sizeOptionValues[3],
  ),
];
