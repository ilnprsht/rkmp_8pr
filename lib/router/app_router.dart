import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../screens/home_screen.dart';
import '../screens/all_products_screen.dart';
import '../screens/favorites_screen.dart';
import '../screens/product_form_screen.dart';
import '../screens/product_detail_screen.dart';
import '../models/product.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/products',
      builder: (context, state) => const AllProductsScreen(),
    ),
    GoRoute(
      path: '/favorites',
      builder: (context, state) => const FavoritesScreen(),
    ),
    GoRoute(
      path: '/add',
      builder: (context, state) => const ProductFormScreen(),
    ),
    GoRoute(
      path: '/details',
      builder: (context, state) {
        final p = state.extra as Product;
        return ProductDetailScreen(product: p);
      },
    ),
  ],
);
