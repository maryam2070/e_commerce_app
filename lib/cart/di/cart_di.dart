import 'package:e_commerce_app/cart/domain/use_cases/add_to_cart_use_case.dart';
import 'package:e_commerce_app/cart/domain/use_cases/delete_from_cart.dart';
import 'package:get_it/get_it.dart';

import '../data/repository/cart_repository_impl.dart';
import '../domain/repository/cart_repository.dart';
import '../domain/use_cases/get_cart_use_case.dart';

final getIt = GetIt.I;

void cartSetup() {
  getIt.registerSingleton<CartRepository>(
      CartRepositoryImpl(ds: getIt.get(), authDs: getIt.get()));
  getIt.registerSingleton<AddToCartUseCase>(
      AddToCartUseCase(repository: getIt.get()));
  getIt.registerSingleton<GetCartUseCase>(
      GetCartUseCase(repository: getIt.get()));
  getIt.registerSingleton<DeleteFromCartUseCase>(
      DeleteFromCartUseCase(repository: getIt.get()));
}
