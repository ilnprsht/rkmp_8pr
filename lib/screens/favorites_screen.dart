// lib/screens/favorites_screen.dart
import 'package:flutter/material.dart';
import '../state/products_container.dart';
import '../models/product.dart';
import '../widgets/product_tile.dart';
import 'product_detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ProductsContainer.of(context);
    final List<Product> favorites = controller.favorites();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Избранное'),
        centerTitle: true,
      ),
      body: favorites.isEmpty
          ? const Center(child: Text('В избранном пусто'))
          : ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          final p = favorites[index];
          return InkWell(
            onTap: () {
              // Вертикальный переход к деталям
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProductDetailScreen(product: p),
                ),
              );
            },
            child: ProductTile(
              product: p,
              // ВАЖНО: не используем setState — контроллер сам дернёт notifyListeners()
              onToggleFavorite: () => controller.toggleFavorite(p.id),
              onDelete: () => controller.deleteProduct(p.id),
            ),
          );
        },
      ),
    );
  }
}
