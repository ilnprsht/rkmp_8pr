import 'package:flutter/foundation.dart';
import '../models/product.dart';

class ProductsController extends ChangeNotifier {
  final List<Product> _products = [];
  List<Product> get products => List.unmodifiable(_products);

  String? _categoryFilter;
  String? get categoryFilter => _categoryFilter;

  void setCategoryFilter(String? value) {
    if (_categoryFilter == value) return;
    _categoryFilter = value;
    notifyListeners();
  }

  List<Product> get filteredProducts {
    if (_categoryFilter == null) return products;
    return products.where((p) => p.category == _categoryFilter).toList();
  }

  List<Product> get filteredFavorites {
    final favs = _products.where((p) => p.isFavorite).toList();
    if (_categoryFilter == null) return favs;
    return favs.where((p) => p.category == _categoryFilter).toList();
  }

  Future<void> loadInitial() async {
    if (_products.isNotEmpty) return;
    _products.addAll([
      Product(
        id: 1,
        name: 'MACximal Matte Lipstick Russian Red',
        brand: 'MAC',
        category: 'Декоративная',
        volume: '3.5 г',
        expirationDate: '08.2027',
        rating: 4.7,
        isFavorite: false,
        imageUrl:
        'https://ir.ozone.ru/s3/multimedia-1-i/c1000/7038468774.jpg',
      ),
      Product(
        id: 2,
        name: 'Good Girl Gone Bad',
        brand: 'Killian',
        category: 'Парфюмерия',
        volume: '50 мл',
        expirationDate: '12.2028',
        rating: 5.0,
        isFavorite: true,
        imageUrl:
        'https://www.letu.ru/common/img/pim/2025/10/EX_b9aa478d-31f8-495d-a424-e05b3952beae.jpg',
      ),
      Product(
        id: 3,
        name: 'Galac Niacin 2.0 essence',
        brand: 'Ma:Nyo',
        category: 'Уходовая',
        volume: '30 мл',
        expirationDate: '05.2026',
        rating: 4.7,
        isFavorite: false,
        imageUrl:
        'https://premiumkorea.ru/upload/iblock/761/5572191dc9b1v7dfxm5omuknp15jiuc1.jpg',
      ),
      Product(
        id: 4,
        name: 'Advanced Night Repair',
        brand: 'Estée Lauder',
        category: 'Уходовая',
        volume: '30 мл',
        expirationDate: '03.2027',
        rating: 4.7,
        isFavorite: false,
        imageUrl:
        'https://ir.ozone.ru/s3/multimedia-m/c1000/6641622850.jpg',
      ),
      Product(
        id: 5,
        name: 'Crystal Tint 01 Vintage Apple',
        brand: 'Clio',
        category: 'Декоративная',
        volume: '3.4 г',
        expirationDate: '10.2028',
        rating: 4.9,
        isFavorite: false,
        imageUrl:
        'https://pcdn.goldapple.ru/p/p/19000197603/imgmain.jpg',
      ),
      Product(
        id: 6,
        name: 'Perfect Sculptor',
        brand: 'SHIKSTUDIO',
        category: 'Декоративная',
        volume: '8 г',
        expirationDate: '02.2027',
        rating: 4.4,
        isFavorite: false,
        imageUrl:
        'https://749923.selcdn.ru/shikstore/img/products/1245/1721721980669f647ca6a198.32803669_1080_1520_inset.jpg',
      ),
    ]);
    notifyListeners();
  }

  void addProduct(Product p) {
    final id = _products.isEmpty ? 1 : (_products.last.id + 1);
    _products.add(p.copyWith(id: id));
    notifyListeners();
  }

  void updateProduct(Product p) {
    final i = _products.indexWhere((e) => e.id == p.id);
    if (i >= 0) {
      _products[i] = p;
      notifyListeners();
    }
  }

  void deleteProduct(int id) {
    _products.removeWhere((e) => e.id == id);
    notifyListeners();
  }

  void toggleFavorite(int id) {
    final i = _products.indexWhere((e) => e.id == id);
    if (i >= 0) {
      final old = _products[i];
      _products[i] = old.copyWith(isFavorite: !old.isFavorite);
      notifyListeners();
    }
  }

  List<Product> favorites() =>
      _products.where((p) => p.isFavorite).toList();
}
