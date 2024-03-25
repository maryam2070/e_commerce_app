import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import '../../../../product/domain/models/product.dart';
import '../../../../product/domain/use_cases/get_new_product_list_use_case.dart';
import '../../../../product/domain/use_cases/get_sale_product_list_use_case.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetNewProductListUseCase getNewProductListUseCase;
  final GetSaleProductListUseCase getSaleProductListUseCase;

  HomeBloc(
      {required this.getNewProductListUseCase,
      required this.getSaleProductListUseCase})
      : super(HomeInitial()) {
    on<HomeEvent>((event, emit) async {
      List<Product> l1 = [];
      List<Product> l2 = [];
      if (event is HomeEvent) {
        emit(NewProductsLoading());
        final call1 = await getNewProductListUseCase.call();
        final call2 = await getSaleProductListUseCase.call();

        call1.fold((l) {
          emit(NewProductsError(message: l.message));
        }, (r) {
          l1 = r;

          call2.fold((l) {
            emit(SaleProductsError(message: l.message));
          }, (r) {
            l2 = r;
            emit(HomeSuccess(newProductList: l1, saleProductList: l2));
          });
        });
      }
    });
  }
}
