import '../../features/products/domain/sku.dart';
import '../dame_data.dart';

const _shirtsS = 'C-blue-S-S';
const _shirtsM = 'C-blue-S-M';
const _shirtsL = 'C-blue-S-L';
const _shirtsXL = 'C-blue-S-XL';

const _shirtsImages = [
  "assets/images/Short_sleeve_shirt_blue1.jpeg",
  "assets/images/Short_sleeve_shirt_blue2.jpeg",
  "assets/images/Short_sleeve_shirt_blue3.jpeg",
  "assets/images/Short_sleeve_shirt_blue4.jpeg",
];

final color = colorOptionValues[1];
const _name = 'UNDER ARMOUR Short sleeve shirt';
const _price = 2450.0;
const _productId = 'Hybrid Knit Jacket';

final kBlueShortSleeveShirts = [
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