import 'package:flutter/material.dart';
import '../state/products_container.dart';
import '../widgets/product_tile.dart';
import '../models/product.dart';
import 'product_detail_screen.dart';
import 'product_form_screen.dart';

class AllProductsScreen extends StatefulWidget {
  final bool embedInsideHome;
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
            tooltip: 'Добавить',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProductFormScreen()),
              );
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: products.isEmpty
          ? const Center(child: Text('Каталог пуст'))
          : ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, i) {
          final Product p = products[i];
          return InkWell(
            onTap: () {
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
      // Если экран открыт не как вкладка — покажем FAB
      floatingActionButton: widget.embedInsideHome
          ? null
          : FloatingActionButton(
        onPressed: () {
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
