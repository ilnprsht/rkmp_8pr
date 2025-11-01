import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../state/products_container.dart';
import '../widgets/product_tile.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    final container = ProductsContainer.of(context);
    final favorites = container.getFavorites();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Избранное'),
        actions: [
          IconButton(
            tooltip: 'Router: перейти к списку (go)',
            onPressed: () => context.go('/products'),
            icon: const Icon(Icons.list),
          ),
        ],
      ),
      body: favorites.isEmpty
          ? const Center(child: Text('В избранном пусто'))
          : ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, i) {
          final p = favorites[i];
          return ProductTile(
            product: p,
            onToggleFavorite: () => setState(() => container.toggleFavorite(p.id)),
            onDelete: () => setState(() => container.deleteProduct(p.id)),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.swap_horiz),
        label: const Text('Navigator: к списку'),
        onPressed: () {
          // Горизонтальная страничная навигация (замена текущего экрана)
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) {
              context.go('/products');
              return const SizedBox.shrink();
            }),
          );
        },
      ),
    );
  }
}
