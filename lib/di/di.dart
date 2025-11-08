import 'package:get_it/get_it.dart';
import '../state/products_controller.dart';

final getIt = GetIt.instance;

Future<void> initDI() async {
  getIt.registerLazySingleton<ProductsController>(() {
    final c = ProductsController();
    c.loadInitial();
    return c;
  });
}


