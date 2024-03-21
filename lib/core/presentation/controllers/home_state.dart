part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class SaleProductsLoading extends HomeState {}

class SaleProductsError extends HomeState {
  final String message;

  SaleProductsError({required this.message});
}

class NewProductsLoading extends HomeState {}

class NewProductsError extends HomeState {
  final String message;

  NewProductsError({required this.message});
}

class HomeSuccess extends HomeState {
  final List<Product> newProductList;
  final List<Product> saleProductList;

  HomeSuccess({required this.newProductList, required this.saleProductList});
}
