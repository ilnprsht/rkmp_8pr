import 'package:flutter/material.dart';
import 'state/products_container.dart';
import 'router/app_router.dart';

void main() => runApp(const AppRoot());

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return ProductsContainer(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Каталог косметики',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.pinkAccent),
          useMaterial3: true,
        ),
        routerConfig: appRouter,
      ),
    );
  }
}
