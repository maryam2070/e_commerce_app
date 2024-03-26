part of 'cart_bloc.dart';

@immutable
abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartError extends CartState {
  final String message;

  CartError({required this.message});
}

class AddToCartSuccess extends CartState {

}

class GetCartSuccess extends CartState {
  List<AddToCartModel> models;
  GetCartSuccess({required this.models});
}
class DeleteFromCartSuccess extends CartState {
  DeleteFromCartSuccess();
}
class AddOrderSuccess extends CartState {

}
class GetOrdersSuccess extends CartState {
  List<OrderModel> orders;
  GetOrdersSuccess({required this.orders});
}

class CancelOrderSuccess extends CartState {
  CancelOrderSuccess();
}