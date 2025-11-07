import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../screens/home_screen.dart';
import '../screens/all_products_screen.dart';
import '../screens/favorites_screen.dart';
import '../screens/product_form_screen.dart';
import '../screens/product_detail_screen.dart';
import '../state/products_container.dart';
import '../models/product.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          path: 'products',
          name: 'products',
          builder: (context, state) => const AllProductsScreen(embedInsideHome: false),
        ),
        GoRoute(
          path: 'favorites',
          name: 'favorites',
          builder: (context, state) => const FavoritesScreen(),
        ),
        GoRoute(
          path: 'add',
          name: 'add',
          builder: (context, state) => const ProductFormScreen(),
        ),
        GoRoute(
          path: 'details/:id',
          name: 'details',
          builder: (context, state) {
            final id = int.tryParse(state.pathParameters['id'] ?? '');
            if (id == null) {
              return const Scaffold(body: Center(child: Text('Неверный id')));
            }
            final container = ProductsContainer.of(context);
            final product = container.products.firstWhere(
                  (p) => p.id == id,
              orElse: () => Product(
                id: id, name: 'Не найдено', brand: '-', category: '-',
                volume: '-', expirationDate: '-', rating: 0, isFavorite: false,
              ),
            );
            return ProductDetailScreen(product: product);
          },
        ),
      ],
    ),
  ],
);
