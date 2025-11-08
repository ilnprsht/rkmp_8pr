import 'package:flutter/widgets.dart';
import 'products_controller.dart';

class ProductsContainer extends InheritedNotifier<ProductsController> {
  const ProductsContainer({
    super.key,
    required ProductsController controller,
    required Widget child,
  }) : super(notifier: controller, child: child);

  static ProductsController of(BuildContext context) {
    final w = context.dependOnInheritedWidgetOfExactType<ProductsContainer>();
    assert(w != null, 'ProductsContainer not found. Wrap MaterialApp in ProductsContainer.');
    return w!.notifier!;
  }
}

