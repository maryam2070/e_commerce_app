import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/auth/data/data_sources/auth_data_source.dart';
import 'package:e_commerce_app/auth/data/repositories/auth_repository_impl.dart';
import 'package:e_commerce_app/auth/domain/repositories/auth_repository.dart';
import 'package:e_commerce_app/auth/domain/usecases/google_signin_use_case.dart';
import 'package:e_commerce_app/auth/domain/usecases/login_use_case.dart';
import 'package:e_commerce_app/auth/domain/usecases/sign_up_use_case.dart';
import 'package:e_commerce_app/home/domain/use_cases/get_new_product_list_use_case.dart';
import 'package:e_commerce_app/shared/data/data_sources/firestore_data_source.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import '../data/repositories/home_repository_impl.dart';
import '../domain/repositories/home_repository.dart';
import '../domain/use_cases/get_sale_product_list_use_case.dart';


final getIt = GetIt.I;

void homeSetup() {

  // getIt.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);
  //
  // getIt.registerSingleton<FirestoreDataSource>(
  //     FirestoreDataSourceImpl(firestore: getIt.get()));

  getIt.registerSingleton<HomeRepository>(
      HomeRepositoryImpl(ds: getIt.get()));

  getIt.registerSingleton<GetNewProductListUseCase>(
      GetNewProductListUseCase(repository: getIt.get()));
  getIt.registerSingleton<GetSaleProductListUseCase>(
      GetSaleProductListUseCase(repository: getIt.get()));
}
