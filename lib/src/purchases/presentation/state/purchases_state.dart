import 'package:karate_stars_app/src/common/presentation/states/default_state.dart';
import 'package:karate_stars_app/src/purchases/domain/product.dart';

typedef PurchasesState = DefaultState<PurchasesStateData>;

class PurchasesStateData {
  final List<Product> products;

  PurchasesStateData({required this.products});
}

