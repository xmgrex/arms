import '../dame_data.dart';
import '../test_products.dart';

const _shirtsS = 'C-gray-S-S';
const _shirtsM = 'C-gray-S-M';
const _shirtsL = 'C-gray-S-L';
const _shirtsXL = 'C-gray-S-XL';

const _shirtsImages = [
  "assets/images/Short_sleeve_shirt_gray1.jpeg",
  "assets/images/Short_sleeve_shirt_gray2.jpeg",
  "assets/images/Short_sleeve_shirt_gray3.jpeg",
  "assets/images/Short_sleeve_shirt_gray4.jpeg",
];

final color = colorOptionValues[3];
const _name = 'UNDER ARMOUR Short sleeve shirt';
const _price = 2450.0;
const _productId = '1';

final kGrayShortSleeveShirts = [
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
