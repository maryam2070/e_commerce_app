import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/auth/domain/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/utilities/errors/failures.dart';

class SignUpUseCase {
  AuthRepository repository;

  SignUpUseCase({required this.repository});

  Future<Either<Failure, void>> call(
      String email, String password, Map<String, dynamic> data) async {
    Either<Failure, void>? response2 = null;

    final response1 = await callAuth(email, password);

    response1.fold((l) => Unit, (r) async {
      response2 = await callAssignData(r!.uid, data);
    });

    return (response2 != null) ? response1.bind((a) => response2!) : response1;
  }

  Future<Either<Failure, void>> callAssignData(
      String uid, Map<String, dynamic> data) async {
    return await repository.assignUserData(uid, data);
  }

  Future<Either<Failure, User?>> callAuth(String email, String password) async {
    return await repository.signUpWithEmailAndPassword(email, password);
  }
}
