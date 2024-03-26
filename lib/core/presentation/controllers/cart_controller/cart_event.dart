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

class AddOrderEvent extends CartEvent{
  final OrderModel order;

  AddOrderEvent({required this.order});
}
class GetOrdersEvent extends CartEvent{
  GetOrdersEvent();
}

class CancelOrderEvent extends CartEvent{
  final OrderModel order;

  CancelOrderEvent({required this.order});
}