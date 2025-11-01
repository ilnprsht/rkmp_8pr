import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'all_products_screen.dart';
import 'favorites_screen.dart';
import 'product_form_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _tab = 0;

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      const AllProductsScreen(embedInsideHome: true),
      const FavoritesScreen(),
      const ProductFormScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Каталог косметической продукции'),
        centerTitle: true,
      ),
      body: pages[_tab],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tab,
        onTap: (i) {
          setState(() => _tab = i);
          switch (i) {
            case 0: context.go('/'); break;
            case 1: context.go('/favorites'); break;
            case 2: context.go('/add'); break;
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Все товары'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Избранное'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Добавить'),
        ],
      ),
    );
  }
}
