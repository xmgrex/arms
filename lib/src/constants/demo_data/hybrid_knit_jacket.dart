import '../../features/products/domain/product.dart';
import '../dame_data.dart';

const _jacketS = 'N-j-C-non-S-S';
const _jacketM = 'N-j-C-non-S-M';
const _jacketL = 'N-j-C-non-S-L';
const _jacketXL = 'N-j-C-non-S-XL';

const _jacketImages = [
  "assets/images/UA_hybrid_knit_jacket1.jpeg",
  "assets/images/UA_hybrid_knit_jacket2.jpg",
  "assets/images/UA_hybrid_knit_jacket3.jpg",
  "assets/images/UA_hybrid_knit_jacket4.jpg",
];

const _name = 'UNDER ARMOUR Hybrid Knit Jacket';
const _price = 9240.0;
const _productId = 'Hybrid Knit Jacket';

final kHybridKnitJacket = Product(
  id: _productId,
  name: _name,
  description: faker.lorem.sentence(),
  imageUrl: _jacketImages[0],
  price: _price,
  sizes: sizeOptionValues,
);

final kHybridKnitJacketsList = [
  createSKU(
    _productId,
    _name,
    _price,
    _jacketImages,
    _jacketS,
    discountRate10,
    inventory: 0,
    sizeOption: sizeOptionValues[0],
  ),
  createSKU(
    _productId,
    _name,
    _price,
    _jacketImages,
    _jacketM,
    discountRate10,
    inventory: 5,
    sizeOption: sizeOptionValues[1],
  ),
  createSKU(
    _productId,
    _name,
    _price,
    _jacketImages,
    _jacketL,
    discountRate10,
    sizeOption: sizeOptionValues[2],
  ),
  createSKU(
    _productId,
    _name,
    _price,
    _jacketImages,
    _jacketXL,
    discountRate10,
    sizeOption: sizeOptionValues[3],
  ),
];
