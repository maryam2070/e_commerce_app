import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/utilities/errors/failures.dart';
import '../repositories/auth_repository.dart';

class ForgotPasswordUseCase {
  AuthRepository repository;

  ForgotPasswordUseCase({required this.repository});

  Future<Either<Failure, void>> call(String email) async {
    return await repository.forgotPassword(email);
  }
}
