import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../models/product.dart';
import '../state/products_controller.dart';
import 'product_form_screen.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final repo = GetIt.I<ProductsController>();

    return AnimatedBuilder(
      animation: repo,
      builder: (context, _) {
        final fresh = repo.products.firstWhere(
              (e) => e.id == product.id,
          orElse: () => product,
        );

        return Scaffold(
          appBar: AppBar(title: const Text('Информация о товаре')),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (fresh.imageUrl != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      fresh.imageUrl!,
                      height: 220,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                const SizedBox(height: 12),
                Text(fresh.name,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                Text('Бренд: ${fresh.brand}'),
                Text('Категория: ${fresh.category}'),
                Text('Объём: ${fresh.volume}'),
                Text('Срок годности: ${fresh.expirationDate}'),
                Text('Рейтинг: ★ ${fresh.rating.toStringAsFixed(1)}'),
                const Divider(height: 24),
                Row(
                  children: [
                    IconButton(
                      tooltip: fresh.isFavorite
                          ? 'Убрать из избранного'
                          : 'В избранное',
                      icon: Icon(fresh.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border),
                      onPressed: () => repo.toggleFavorite(fresh.id),
                    ),
                    const SizedBox(width: 8),
                    FilledButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ProductFormScreen(editing: fresh),
                          ),
                        );
                      },
                      icon: const Icon(Icons.edit),
                      label: const Text('Редактировать'),
                    ),
                    const SizedBox(width: 8),
                    OutlinedButton.icon(
                      onPressed: () {
                        repo.deleteProduct(fresh.id);
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.delete_outline),
                      label: const Text('Удалить'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
