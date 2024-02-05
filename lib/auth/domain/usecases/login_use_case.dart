import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/auth/domain/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';


import '../../../core/utilities/errors/failures.dart';
class LoginUseCase {
  AuthRepository repository;

  LoginUseCase({required this.repository});

  Future<Either<Failure, User?>> call(String email, String password) async {
    return await repository.loginWithEmailAndPassword(email, password);
  }
}
