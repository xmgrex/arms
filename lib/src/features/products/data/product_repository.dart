import 'package:arms/src/features/products/domain/product_option.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../constants/test_products.dart';
import '../domain/product.dart';
import '../domain/sku.dart';

class FakeProductsRepository {
  FakeProductsRepository();

  final List<Product> _products = kTestProducts;
  final List<SKU> _skus = kTestSKUs;

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

  Future<List<SKU>> fetchSKUsList(String id) async {
    await Future.delayed(const Duration(seconds: 1));
    return Future.value(_skus);
  }

  Stream<List<Product>> watchProductsList() async* {
    await Future.delayed(const Duration(seconds: 2));
    yield _products;
  }

  Stream<List<SKU>> watchSKUsList(String productId) async* {
    await Future.delayed(const Duration(seconds: 1));
    yield _skus;
  }

  Stream<Product?> watchProduct(String id) {
    return watchProductsList()
        .map((products) => products.firstWhere((product) => product.id == id));
  }

  Future<List<ProductOption>> fetchProductOptions(String productId) async {
    await Future.delayed(const Duration(seconds: 1));
    return Future.value(options);
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

final skusListFutureProvider =
    FutureProvider.autoDispose.family<List<SKU>, String>((ref, id) {
  final productsRepository = ref.watch(productsRepositoryProvider);
  return productsRepository.fetchSKUsList(id);
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

final productOptionsListProvider =
    FutureProvider.autoDispose.family<List<ProductOption>, String>((ref, id) {
  final productsRepository = ref.watch(productsRepositoryProvider);
  return productsRepository.fetchProductOptions(id);
});
