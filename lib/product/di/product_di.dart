import 'package:get_it/get_it.dart';

import '../data/repositories/product_repository_impl.dart';
import '../domain/repositories/product_repository.dart';
import '../domain/use_cases/get_new_product_list_use_case.dart';
import '../domain/use_cases/get_sale_product_list_use_case.dart';

final getIt = GetIt.I;

void productSetup() {
  getIt.registerSingleton<ProductRepository>(ProductRepositoryImpl(ds: getIt.get()));

  getIt.registerSingleton<GetNewProductListUseCase>(
      GetNewProductListUseCase(repository: getIt.get()));
  getIt.registerSingleton<GetSaleProductListUseCase>(
      GetSaleProductListUseCase(repository: getIt.get()));
}
