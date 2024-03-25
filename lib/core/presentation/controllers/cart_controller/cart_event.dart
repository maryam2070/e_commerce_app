part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}
class AddToCartEvent extends CartEvent{
  final AddToCartModel model;

  AddToCartEvent({required this.model});
}
class GetCartEvent extends CartEvent{
  GetCartEvent();
}

class DeleteFromCartEvent extends CartEvent{
  final String id;
  DeleteFromCartEvent({required this.id});
}
