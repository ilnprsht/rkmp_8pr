import 'package:flutter/material.dart';
import 'state/products_container.dart';
import 'state/products_controller.dart';
import 'router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final controller = ProductsController()..loadInitial();
  runApp(AppRoot(controller: controller));
}

class AppRoot extends StatelessWidget {
  final ProductsController controller;
  const AppRoot({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ProductsContainer(
      controller: controller,
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Каталог косметики — Inherited',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.pinkAccent),
          useMaterial3: true,
        ),
        routerConfig: appRouter,
      ),
    );
  }
}

