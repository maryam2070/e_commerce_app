import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/utilities/errors/failures.dart';
import '../repositories/auth_repository.dart';

class GoogleSignInUseCase {
  AuthRepository repository;

  GoogleSignInUseCase({required this.repository});

  Future<Either<Failure, User?>> call() async {
    return await repository.signInGoogle();
  }
}
