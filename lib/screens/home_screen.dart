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
    final tabs = <Widget>[
      // Вкладка 0: мини-хаб с кнопками навигации (и Router, и Navigator демо)
      _HomeHub(),
      const FavoritesScreen(),
      const ProductFormScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Каталог косметической продукции'),
        centerTitle: true,
      ),
      body: tabs[_tab],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tab,
        onTap: (i) {
          setState(() => _tab = i);
          // Горизонтальная маршрутизированная навигация (полная замена)
          switch (i) {
            case 0:
              context.go('/'); // главная
              break;
            case 1:
              context.go('/favorites');
              break;
            case 2:
              context.go('/add');
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Главная'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Избранное'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Добавить'),
        ],
      ),
    );
  }
}

class _HomeHub extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Демонстрация навигации',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),

        // Вертикальная маршрутизированная (router): push
        FilledButton(
          onPressed: () => context.push('/products'),
          child: const Text('Router: перейти на "Все товары" (context.push)'),
        ),
        const SizedBox(height: 8),

        // Горизонтальная маршрутизированная: go (замена)
        OutlinedButton(
          onPressed: () => context.go('/favorites'),
          child: const Text('Router: перейти на "Избранное" (context.go)'),
        ),
        const SizedBox(height: 24),

        const Divider(),
        const SizedBox(height: 12),
        const Text(
          'Страничная навигация (Navigator)',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),

        // Вертикальная страничная: Navigator.push
        FilledButton.tonal(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AllProductsScreen(embedInsideHome: false)),
            );
          },
          child: const Text('Navigator: push на "Все товары"'),
        ),
        const SizedBox(height: 8),

        // Горизонтальная страничная: Navigator.pushReplacement
        OutlinedButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const FavoritesScreen()),
            );
          },
          child: const Text('Navigator: pushReplacement на "Избранное"'),
        ),
      ],
    );
  }
}
