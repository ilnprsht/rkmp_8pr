import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../state/products_controller.dart';
import '../widgets/product_tile.dart';
import '../widgets/category_filter_bar.dart';
import '../models/product.dart';
import 'product_detail_screen.dart';
import 'product_form_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = GetIt.I<ProductsController>();

    return AnimatedBuilder(
      animation: repo,
      builder: (context, _) {
        final selected = repo.categoryFilter;
        final List<Product> items = repo.filteredFavorites;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Избранное'),
            centerTitle: true,
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
                    ? const Center(child: Text('В избранном ничего не найдено'))
                    : ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final p = items[index];
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
        );
      },
    );
  }
}
