import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Главная')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.list),
              title: const Text('Все товары'),
              onTap: () => context.push('/products'),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text('Избранное'),
              onTap: () => context.push('/favorites'),
            ),
            const Spacer(),
            FilledButton.icon(
              onPressed: () => context.go('/add'), // горизонтально (без шага назад)
              icon: const Icon(Icons.add),
              label: const Text('Добавить продукт'),
            ),
          ],
        ),
      ),
    );
  }
}
