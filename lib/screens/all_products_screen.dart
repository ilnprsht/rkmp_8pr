import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:get_it/get_it.dart';
import '../state/products_controller.dart';
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
    final repo = GetIt.I<ProductsController>();

    return AnimatedBuilder(
      animation: repo,
      builder: (context, _) {
        final selected = repo.categoryFilter;
        final List<Product> items = repo.filteredProducts;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Все товары'),
            actions: [
              IconButton(
                tooltip: 'Добавить',
                icon: const Icon(Icons.add),
                onPressed: () => context.go('/add'),
              ),
            ],
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
                child: CategoryFilterBar(
                  selected: selected,
                  onChanged: repo.setCategoryFilter,
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ProductDetailScreen(product: p),
                          ),
                        );
                      },
                      child: ProductTile(
                        product: p,
                        onToggleFavorite: () => repo.toggleFavorite(p.id),
                        onDelete: () => repo.deleteProduct(p.id),
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
      },
    );
  }
}
