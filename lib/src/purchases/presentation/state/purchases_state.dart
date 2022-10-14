import 'package:karate_stars_app/src/purchases/domain/product.dart';

class PurchasesState<T> {
  PurchasesState();

  factory PurchasesState.notAvailable() => NotAvailableState();

  factory PurchasesState.loading(String message) =>
      LoadingState(message: message);

  factory PurchasesState.error(String message) => ErrorState(message: message);

  factory PurchasesState.productsLoaded(List<Product> products) =>
      ProductsLoadedState(products: products);

/*  factory DefaultState.loaded(T data) => LoadedState(data: data);
*/
}

class LoadingState<T> extends PurchasesState<T> {
  final String message;

  LoadingState({required this.message});
}

class NotAvailableState<T> extends PurchasesState<T> {}

class ErrorState<T> extends PurchasesState<T> {
  final String message;

  ErrorState({required this.message});
}

class ProductsLoadedState<T> extends PurchasesState<T> {
  final List<Product> products;

  ProductsLoadedState({required this.products});
}
/*
class LoadedState<T> extends DefaultState<T> {
  final T data;

  LoadedState({required this.data});
}

*/
