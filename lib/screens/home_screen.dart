import 'package:flutter/material.dart';
import 'all_products_screen.dart';
import 'favorites_screen.dart';
import 'product_form_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Каталог косметической продукции'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Навигация',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),

          // ВЕРТИКАЛЬНО: в список товаров
          FilledButton.icon(
            icon: const Icon(Icons.list),
            label: const Text('Все товары'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AllProductsScreen(embedInsideHome: false),
                ),
              );
            },
          ),
          const SizedBox(height: 8),

          // ВЕРТИКАЛЬНО: в избранное
          FilledButton.icon(
            icon: const Icon(Icons.favorite),
            label: const Text('Избранное'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const FavoritesScreen()),
              );
            },
          ),
          const SizedBox(height: 8),

          // ВЕРТИКАЛЬНО: форма добавления
          FilledButton.icon(
            icon: const Icon(Icons.add),
            label: const Text('Добавить продукт'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProductFormScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
