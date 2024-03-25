part of 'cart_bloc.dart';

@immutable
abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartError extends CartState {
  final String message;

  CartError({required this.message});
}

class AddToCartSuccessSuccess extends CartState {

}

class GetCartSuccess extends CartState {
  List<AddToCartModel> models;
  GetCartSuccess({required this.models});
}
class DeleteFromCartSuccess extends CartState {

  DeleteFromCartSuccess();
}

