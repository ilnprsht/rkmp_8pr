import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // ← нужно для context.pop()
import '../models/product.dart';
import '../state/products_container.dart';
import '../widgets/product_card.dart';
import 'product_form_screen.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;
  const ProductDetailScreen({super.key, required this.product});

  Future<void> _confirmDelete(BuildContext context) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Удалить запись?'),
        content: Text('Товар «${product.name}» будет удалён из каталога.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Отмена')),
          FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Удалить')),
        ],
      ),
    );
    if (ok == true) {
      final container = ProductsContainer.of(context);
      container.deleteProduct(product.id);

      // Возврат после удаления: если можем pop — выходим назад,
      // иначе уходим на список через маршрутизатор.
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      } else {
        context.go('/products');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final container = ProductsContainer.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Детали товара'),
        actions: [
          IconButton(
            tooltip: 'Назад',
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              // Если экран открыт через Navigator.push → pop,
              // иначе (router) → context.pop()
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              } else {
                context.pop();
              }
            },
          ),
        ],
      ),
      body: ProductCard(
        product: product,
        onToggleFavorite: () => container.toggleFavorite(product.id),
        onEdit: () {
          // Редактирование через страничную навигацию (как в ПР5/ПР6)
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ProductFormScreen(editing: product),
            ),
          );
        },
        onDelete: () => _confirmDelete(context),
      ),
    );
  }
}
