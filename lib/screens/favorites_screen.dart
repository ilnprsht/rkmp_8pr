import 'package:flutter/material.dart';
import '../state/products_container.dart';
import '../widgets/product_tile.dart';
import '../widgets/category_filter_bar.dart';
import '../models/product.dart';
import 'product_detail_screen.dart';
import 'product_form_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = ProductsContainer.of(context);
    final selected = c.categoryFilter;
    final List<Product> items = c.filteredFavorites;

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
              onChanged: (v) => c.setCategoryFilter(v),
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
    );
  }
}
