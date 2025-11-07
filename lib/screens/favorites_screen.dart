import 'package:flutter/material.dart';
import '../state/products_container.dart';
import '../models/product.dart';
import '../widgets/product_tile.dart';
import 'product_detail_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    final container = ProductsContainer.of(context);
    final List<Product> favorites = container.getFavorites();

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
              // ВЕРТИКАЛЬНО: в детали избранного
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProductDetailScreen(product: p),
                ),
              );
            },
            child: ProductTile(
              product: p,
              onToggleFavorite: () {
                setState(() => container.toggleFavorite(p.id));
              },
              onDelete: () {
                setState(() => container.deleteProduct(p.id));
              },
            ),
          );
        },
      ),
    );
  }
}
