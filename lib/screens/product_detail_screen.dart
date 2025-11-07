import 'package:flutter/material.dart';
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
        content: Text('Товар «${product.name}» будет удалён.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Отмена')),
          FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Удалить')),
        ],
      ),
    );
    if (ok == true) {
      final container = ProductsContainer.of(context);
      container.deleteProduct(product.id);
      if (Navigator.canPop(context)) Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final container = ProductsContainer.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Детали товара'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context), // вертикальный возврат
        ),
      ),
      body: ProductCard(
        product: product,
        onToggleFavorite: () => container.toggleFavorite(product.id),
        onEdit: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => ProductFormScreen(editing: product)),
          );
        },
        onDelete: () => _confirmDelete(context),
      ),
    );
  }
}
