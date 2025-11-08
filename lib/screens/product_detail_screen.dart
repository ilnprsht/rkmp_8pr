import 'package:flutter/material.dart';
import '../models/product.dart';
import '../state/products_container.dart';
import 'product_form_screen.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final repo = ProductsContainer.scope(context).repository;

    return Scaffold(
      appBar: AppBar(title: const Text('Информация о товаре')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (product.imageUrl != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  product.imageUrl!,
                  height: 220,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(height: 12),
            Text(product.name,
                style:
                const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Text('Бренд: ${product.brand}'),
            Text('Категория: ${product.category}'),
            Text('Объём: ${product.volume}'),
            Text('Срок годности: ${product.expirationDate}'),
            Text('Рейтинг: ★ ${product.rating.toStringAsFixed(1)}'),
            const Divider(height: 24),
            Row(
              children: [
                IconButton(
                  tooltip: product.isFavorite
                      ? 'Убрать из избранного'
                      : 'В избранное',
                  icon: Icon(product.isFavorite
                      ? Icons.favorite
                      : Icons.favorite_border),
                  onPressed: () => repo.toggleFavorite(product.id),
                ),
                const SizedBox(width: 8),
                FilledButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductFormScreen(editing: product),
                      ),
                    );
                  },
                  icon: const Icon(Icons.edit),
                  label: const Text('Редактировать'),
                ),
                const SizedBox(width: 8),
                OutlinedButton.icon(
                  onPressed: () {
                    repo.deleteProduct(product.id);
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
  }
}
