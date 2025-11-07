import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../state/products_container.dart';
import '../widgets/product_tile.dart';
import '../models/product.dart';
import 'product_detail_screen.dart';

class AllProductsScreen extends StatefulWidget {
  final bool embedInsideHome;
  const AllProductsScreen({super.key, this.embedInsideHome = false});

  @override
  State<AllProductsScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
  @override
  Widget build(BuildContext context) {
    final container = ProductsContainer.of(context);
    final List<Product> products = container.products;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Все товары'),
        // УБРАНЫ кнопки "к избранному" и "заменить на избранное"
        actions: [
          // "+" — ГОРИЗОНТАЛЬНАЯ маршрутизированная навигация:
          // заменяем текущий экран на форму добавления, чтобы нельзя было вернуться
          IconButton(
            tooltip: 'Добавить',
            icon: const Icon(Icons.add),
            onPressed: () => context.go('/add'),
          ),
        ],
      ),
      body: products.isEmpty
          ? const Center(child: Text('Каталог пуст'))
          : ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, i) {
          final p = products[i];
          return InkWell(
            onTap: () {
              // Вертикальная страничная навигация в детали
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProductDetailScreen(product: p),
                ),
              );
            },
            child: ProductTile(
              product: p,
              onToggleFavorite: () =>
                  setState(() => container.toggleFavorite(p.id)),
              onDelete: () =>
                  setState(() => container.deleteProduct(p.id)),
            ),
          );
        },
      ),
      // По желанию можно оставить FAB — тоже пусть ведёт горизонтально:
      floatingActionButton: widget.embedInsideHome
          ? null
          : FloatingActionButton(
        tooltip: 'Добавить',
        onPressed: () => context.go('/add'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
