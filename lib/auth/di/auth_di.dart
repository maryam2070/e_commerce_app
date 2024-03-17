import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/auth/data/data_sources/auth_data_source.dart';
import 'package:e_commerce_app/auth/data/repositories/auth_repository_impl.dart';
import 'package:e_commerce_app/auth/domain/repositories/auth_repository.dart';
import 'package:e_commerce_app/auth/domain/usecases/google_signin_use_case.dart';
import 'package:e_commerce_app/auth/domain/usecases/login_use_case.dart';
import 'package:e_commerce_app/auth/domain/usecases/sign_up_use_case.dart';
import 'package:e_commerce_app/shared/data/data_sources/firestore_data_source.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import '../domain/usecases/forgot_password_use_case.dart';

final getIt = GetIt.I;

void authSetup() {
  getIt.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);

  getIt.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);

  getIt.registerSingleton<AuthDataSource>(AuthDataSourceImpl(getIt.get()));
  getIt.registerSingleton<FirestoreDataSource>(
      FirestoreDataSourceImpl(firestore: getIt.get()));

  getIt.registerSingleton<AuthRepository>(
      AuthRepositoryImpl(ds: getIt.get(), firestoreDs: getIt.get()));

  getIt
      .registerSingleton<SignUpUseCase>(SignUpUseCase(repository: getIt.get()));
  getIt.registerSingleton<LoginUseCase>(LoginUseCase(repository: getIt.get()));

  getIt.registerSingleton<GoogleSignInUseCase>(
      GoogleSignInUseCase(repository: getIt.get()));
  getIt.registerSingleton<ForgotPasswordUseCase>(
      ForgotPasswordUseCase(repository: getIt.get()));
}
