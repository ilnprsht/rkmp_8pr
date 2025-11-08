import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../state/products_container.dart';
import '../models/product.dart';
import '../widgets/product_tile.dart';
import 'product_detail_screen.dart';

class AllProductsScreen extends StatelessWidget {
  final bool embedInsideHome;
  const AllProductsScreen({super.key, this.embedInsideHome = false});

  @override
  Widget build(BuildContext context) {
    final c = ProductsContainer.of(context);
    final List<Product> products = c.products;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Все товары'),
        actions: [
          // пример вертикальной маршрутизированной навигации
          IconButton(
            tooltip: 'Добавить',
            icon: const Icon(Icons.add),
            onPressed: () => context.go('/add'), // как ты просила для + (горизонтально)
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
              // страничная вертикальная навигация в детали
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProductDetailScreen(product: p),
                ),
              );
            },
            child: ProductTile(
              product: p,
              onToggleFavorite: () => c.toggleFavorite(p.id),
              onDelete: () => c.deleteProduct(p.id),
            ),
          );
        },
      ),
      floatingActionButton: embedInsideHome
          ? null
          : FloatingActionButton(
        tooltip: 'Добавить',
        onPressed: () => context.go('/add'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
