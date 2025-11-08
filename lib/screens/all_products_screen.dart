import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../state/products_container.dart';
import '../widgets/product_tile.dart';
import '../widgets/category_filter_bar.dart';
import '../models/product.dart';
import 'product_detail_screen.dart';
import 'product_form_screen.dart';

class AllProductsScreen extends StatelessWidget {
  final bool embedInsideHome;
  const AllProductsScreen({super.key, this.embedInsideHome = false});

  @override
  Widget build(BuildContext context) {
    final c = ProductsContainer.of(context);
    final selected = c.categoryFilter;
    final List<Product> items = c.filteredProducts;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Все товары'),
        actions: [
          IconButton(
            tooltip: 'Добавить',
            icon: const Icon(Icons.add),
            onPressed: () => context.go('/add'), // горизонтально на форму
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: CategoryFilterBar(
              selected: selected,
              onChanged: (v) => c.setCategoryFilter(v),
            ),
          ),
          const Divider(height: 8),
          Expanded(
            child: items.isEmpty
                ? const Center(child: Text('Ничего не найдено'))
                : ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, i) {
                final p = items[i];
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
                    onToggleFavorite: () => c.toggleFavorite(p.id),
                    onDelete: () => c.deleteProduct(p.id),
                    onEdit: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProductFormScreen(editing: p),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
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
