import 'package:flutter/material.dart';
import 'di/di.dart';
import 'router/app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDI();
  runApp(const AppRootGetIt());
}

class AppRootGetIt extends StatelessWidget {
  const AppRootGetIt({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Каталог косметики',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pinkAccent),
        useMaterial3: true,
      ),
      routerConfig: appRouter,
    );
  }
}


