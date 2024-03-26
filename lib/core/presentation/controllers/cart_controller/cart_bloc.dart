import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/cart/domain/models/add_to_cart_model.dart';
import 'package:e_commerce_app/cart/domain/use_cases/add_order_use_case.dart';
import 'package:meta/meta.dart';

import '../../../../cart/domain/models/order.dart';
import '../../../../cart/domain/use_cases/add_to_cart_use_case.dart';
import '../../../../cart/domain/use_cases/cancel_order_use_case.dart';
import '../../../../cart/domain/use_cases/delete_from_cart.dart';
import '../../../../cart/domain/use_cases/get_cart_use_case.dart';
import '../../../../cart/domain/use_cases/get_orders_use_case.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final AddToCartUseCase addToCartUseCase;
  final GetCartUseCase getCartUseCase;
  final DeleteFromCartUseCase deleteFromCartUseCase;
  final AddOrderUseCase addOrderUseCase;
  final GetOrdersUseCase getOrdersUseCase;
  final CancelOrderUseCase cancelOrderUseCase;
  CartBloc(
      {required this.addToCartUseCase,
      required this.getCartUseCase,
      required this.deleteFromCartUseCase,
      required this.addOrderUseCase,
      required this.getOrdersUseCase,
      required this.cancelOrderUseCase})
      : super(CartInitial()) {
    on<CartEvent>((event, emit) async {
      if (event is AddToCartEvent) {
        emit(CartLoading());
        await addToCartUseCase.call(model: event.model).then((value) {
          emit(AddToCartSuccess());
        }).onError((error, stackTrace) {
          emit(CartError(message: error.toString()));
        });
      }
      if (event is GetCartEvent) {
        emit(CartLoading());
        final call1 = await getCartUseCase.call();

        call1.fold((l) {
          emit(CartError(message: l.message));
        }, (r) {
          emit(GetCartSuccess(
              models:
                  (r.where((element) => element.isChecked == false).toList())));
        });
      }
      if (event is DeleteFromCartEvent) {
        emit(CartLoading());
        final call1 = await deleteFromCartUseCase.call(id: event.id);
        call1.fold((l) {
          emit(CartError(message: l.message));
        }, (r) {
          emit(DeleteFromCartSuccess());
        });
      }
      if (event is AddOrderEvent) {
        emit(CartLoading());
        final call1 = await addOrderUseCase.call(order: event.order);
        call1.fold((l) {
          emit(CartError(message: l.message));
        }, (r) {
          emit(AddOrderSuccess());
        });
      }

      if (event is GetOrdersEvent) {
        emit(CartLoading());
        final call1 = await getOrdersUseCase.call();

        call1.fold((l) {
          emit(CartError(message: l.message));
        }, (r) {
          emit(GetOrdersSuccess(orders: r));
        });
      }

      if (event is CancelOrderEvent) {
        emit(CartLoading());
        final call1 = await cancelOrderUseCase.call(order: event.order);
        call1.fold((l) {
          emit(CartError(message: l.message));
        }, (r) {
          emit(CancelOrderSuccess());
        });
      }
    });
  }
}
