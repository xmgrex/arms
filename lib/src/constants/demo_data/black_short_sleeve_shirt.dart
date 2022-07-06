import '../../features/products/domain/product.dart';
import '../dame_data.dart';

const _shirtsS = 'C-black-S-S';
const _shirtsM = 'C-black-S-M';
const _shirtsL = 'C-black-S-L';
const _shirtsXL = 'C-black-S-XL';

const _shirtsImages = [
  "assets/images/Short_sleeve_shirt1.jpeg",
  "assets/images/Short_sleeve_shirt2.jpeg",
  "assets/images/Short_sleeve_shirt3.jpeg",
  "assets/images/Short_sleeve_shirt4.jpeg",
];

final color = colorOptionValues[0];
const _name = 'UNDER ARMOUR Short sleeve shirt';
const _price = 2450.0;
const _productId = 'Short sleeve shirt';

final kShortSleeveShirts = Product(
  id: _productId,
  name: _name,
  description: faker.lorem.sentence(),
  imageUrl: _shirtsImages[0],
  price: _price,
  colors: colorOptionValues,
  sizes: sizeOptionValues
);

final kBlackShortSleeveShirts = [
  createSKU(
    _productId,
    _name,
    _price,
    _shirtsImages,
    _shirtsS,
    discountNone,
    colorOption: color,
    sizeOption: sizeOptionValues[0],
  ),
  createSKU(
    _productId,
    _name,
    _price,
    _shirtsImages,
    _shirtsM,
    discountNone,
    inventory: 0,
    colorOption: color,
    sizeOption: sizeOptionValues[1],
  ),
  createSKU(
    _productId,
    _name,
    _price,
    _shirtsImages,
    _shirtsL,
    discountNone,
    colorOption: color,
    sizeOption: sizeOptionValues[2],
  ),
  createSKU(
    _productId,
    _name,
    _price,
    _shirtsImages,
    _shirtsXL,
    discountNone,
    colorOption: color,
    sizeOption: sizeOptionValues[3],
  ),
];