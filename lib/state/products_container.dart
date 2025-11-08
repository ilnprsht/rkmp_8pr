import 'package:flutter/widgets.dart';
import 'products_controller.dart';

class ProductsContainer extends InheritedNotifier<ProductsController> {
  const ProductsContainer({
    super.key,
    required ProductsController controller,
    required Widget child,
  }) : super(notifier: controller, child: child);

  static ProductsContainer scope(BuildContext context) {
    final scope =
    context.dependOnInheritedWidgetOfExactType<ProductsContainer>();
    assert(scope != null,
    'ProductsContainer not found. Wrap MaterialApp in ProductsContainer.');
    return scope!;
  }

  ProductsController get repository => notifier!;
}



