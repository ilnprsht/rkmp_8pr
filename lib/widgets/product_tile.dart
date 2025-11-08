import 'package:flutter/material.dart';
import '../models/product.dart';

/// Карточка товара. Ничего не знает о навигации.
/// Вся логика приходит сверху колбэками.
class ProductTile extends StatelessWidget {
  final Product product;
  final VoidCallback? onToggleFavorite;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;

  const ProductTile({
    super.key,
    required this.product,
    this.onToggleFavorite,
    this.onDelete,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: product.imageUrl == null
              ? const Icon(Icons.image, size: 40)
              : Image.network(
            product.imageUrl!,
            width: 56,
            height: 56,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(product.name),
        subtitle: Text('${product.category} • ${product.volume} • ★ ${product.rating}'),
        trailing: Wrap(
          spacing: 8,
          children: [
            IconButton(
              tooltip: product.isFavorite ? 'Убрать из избранного' : 'В избранное',
              onPressed: onToggleFavorite,
              icon: Icon(
                product.isFavorite ? Icons.favorite : Icons.favorite_border,
              ),
            ),
            IconButton(
              tooltip: 'Редактировать',
              onPressed: onEdit,
              icon: const Icon(Icons.edit),
            ),
            IconButton(
              tooltip: 'Удалить',
              onPressed: onDelete,
              icon: const Icon(Icons.delete_outline),
            ),
          ],
        ),
      ),
    );
  }
}
