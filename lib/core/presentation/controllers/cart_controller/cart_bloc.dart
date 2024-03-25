import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/cart/domain/models/add_to_cart_model.dart';
import 'package:meta/meta.dart';

import '../../../../cart/domain/use_cases/add_to_cart_use_case.dart';
import '../../../../cart/domain/use_cases/delete_from_cart.dart';
import '../../../../cart/domain/use_cases/get_cart_use_case.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final AddToCartUseCase addToCartUseCase;
  final GetCartUseCase getCartUseCase;
  final DeleteFromCartUseCase deleteFromCartUseCase;
  CartBloc({required this.addToCartUseCase,
    required this.getCartUseCase,
  required this.deleteFromCartUseCase})
      : super(CartInitial()) {
    on<CartEvent>((event, emit) async {
      if (event is AddToCartEvent) {
        emit(CartLoading());
        await addToCartUseCase.call(model: event.model).then((value) {
          emit(AddToCartSuccessSuccess());
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
          print("jasnf  " + r.toString());
          emit(GetCartSuccess(models: r));
        });
      }
      if (event is DeleteFromCartEvent) {
        emit(CartLoading());
        final call1 = await deleteFromCartUseCase.call(id:event.id);
        call1.fold((l) {
          emit(CartError(message: l.message));
        }, (r) {
          emit(DeleteFromCartSuccess());
        });
      }
    });
  }
}
