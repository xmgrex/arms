import '../dame_data.dart';

const _shirtsS = 'C-white-S-S';
const _shirtsM = 'C-white-S-M';
const _shirtsL = 'C-white-S-L';
const _shirtsXL = 'C-white-S-XL';

const _shirtsImages = [
  "assets/images/Short_sleeve_shirt_white1.jpeg",
  "assets/images/Short_sleeve_shirt_white2.jpeg",
  "assets/images/Short_sleeve_shirt_white3.jpeg",
  "assets/images/Short_sleeve_shirt_white4.jpeg",
];

final color = colorOptionValues[2];
const _name = 'UNDER ARMOUR Short sleeve shirt';
const _price = 2450.0;
const _productId = '1';

final kWhiteShortSleeveShirts = [
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