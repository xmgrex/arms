import 'package:arms/src/constants/dame_data.dart';
import 'package:arms/src/constants/demo_data/black_short_sleeve_shirt.dart';
import 'package:arms/src/constants/demo_data/blue_short_sleeve_shirt.dart';
import 'package:arms/src/constants/demo_data/gray_short_sleeve_shirt.dart';
import 'package:arms/src/constants/demo_data/hybrid_knit_jacket.dart';
import 'package:arms/src/constants/demo_data/white_short_sleeve_shirt.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import '../../../constants/demo_data/compression_inner_long_sleeves.dart';
import '../domain/product.dart';
import '../domain/sku.dart';

class FakeProductsRepository {
  FakeProductsRepository();

  final List<Product> _products = [
    kShortSleeveShirts,
    kHybridKnitJacket,
    kCompressionInnerLongSleeves,
    // ...kTestProducts,
  ];
  final List<SKU> _shirtSKUs = [
    ...kBlackShortSleeveShirts,
    ...kWhiteShortSleeveShirts,
    ...kBlueShortSleeveShirts,
    ...kGrayShortSleeveShirts,
  ];
  final List<SKU> _jacketSKUs = kHybridKnitJacketsList;
  final List<SKU> _innerSKUs = kCompressionInnerLongSleevesList;

  // final List<SKU> _testSKUs = kTestSKUs;

  List<Product> getProductsList() {
    return _products;
  }

  Future<Product?> fetchProduct(String id) async {
    await Future.delayed(const Duration(seconds: 2));
    return _products.firstWhere((product) => product.id == id);
  }

  Future<List<Product>> fetchProductsList() async {
    await Future.delayed(const Duration(seconds: 2));
    return Future.value(_products);
  }

  Future<List<SKU>> fetchSKUsList(String supplierId, String productId) async {
    await Future.delayed(const Duration(seconds: 1));
    if (productId == 'Short sleeve shirt') {
      return Future.value(_shirtSKUs);
    } else if (productId == 'Hybrid Knit Jacket') {
      return Future.value(_jacketSKUs);
    } else if (productId == 'Compression inner long sleeves') {
      return Future.value(_innerSKUs);
    } else {
      return Future.error('Error');
    }
  }

  Stream<List<Product>> watchProductsList() async* {
    await Future.delayed(const Duration(seconds: 2));
    yield _products;
  }

  Stream<List<SKU>> watchSKUsList(String productId) async* {
    await Future.delayed(const Duration(seconds: 1));
    yield _shirtSKUs;
  }

  Stream<Product?> watchProduct(String id) {
    return watchProductsList()
        .map((products) => products.firstWhere((product) => product.id == id));
  }
}

final productsRepositoryProvider = Provider<FakeProductsRepository>((ref) {
  return FakeProductsRepository();
});

final productsListStreamProvider =
    StreamProvider.autoDispose<List<Product>>((ref) {
  final productsRepository = ref.watch(productsRepositoryProvider);
  return productsRepository.watchProductsList();
});

final productsListFutureProvider =
    FutureProvider.autoDispose<List<Product>>((ref) {
  final productsRepository = ref.watch(productsRepositoryProvider);
  return productsRepository.fetchProductsList();
});

final skusListStreamProvider =
    StreamProvider.autoDispose.family<List<SKU>, String>((ref, id) {
  final productsRepository = ref.watch(productsRepositoryProvider);
  return productsRepository.watchSKUsList(id);
});

final productProvider =
    StreamProvider.autoDispose.family<Product?, String>((ref, id) {
  final productsRepository = ref.watch(productsRepositoryProvider);
  return productsRepository.watchProduct(id);
});
