import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../state/products_container.dart';
import '../widgets/product_tile.dart';
import '../models/product.dart';
import 'product_detail_screen.dart';
import 'product_form_screen.dart';

class AllProductsScreen extends StatefulWidget {
  final bool embedInsideHome; // уже было у тебя
  const AllProductsScreen({super.key, this.embedInsideHome = false});

  @override
  State<AllProductsScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
  @override
  Widget build(BuildContext context) {
    final container = ProductsContainer.of(context);
    final products = container.products;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Все товары'),
        actions: [
          IconButton(
            tooltip: 'Добавить (Router push)',
            onPressed: () => context.push('/add'),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: products.isEmpty
          ? const Center(child: Text('Каталог пуст'))
          : ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, i) {
          final p = products[i];
          return ProductTile(
            product: p,
            onToggleFavorite: () => setState(() => container.toggleFavorite(p.id)),
            onDelete: () => setState(() => container.deleteProduct(p.id)),
          ).applyTapHandlers(
            onTapNavigator: () {
              // Вертикальная страничная навигация (push)
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ProductDetailScreen(product: p)),
              );
            },
            onTapRouter: () {
              // Вертикальная маршрутизированная навигация (push)
              context.push('/details/${p.id}');
            },
          );
        },
      ),
      floatingActionButton: widget.embedInsideHome
          ? null
          : FloatingActionButton(
        onPressed: () {
          // Страничная навигация к форме
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ProductFormScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

// небольшой удобный экстеншен, чтобы не трогать ProductTile
extension on Widget {
  Widget applyTapHandlers({VoidCallback? onTapNavigator, VoidCallback? onTapRouter}) {
    return InkWell(
      onTap: onTapNavigator,           // по умолчанию показываем страничную модель
      onLongPress: onTapRouter,        // длинное нажатие — маршрутизированную
      child: this,
    );
  }
}
