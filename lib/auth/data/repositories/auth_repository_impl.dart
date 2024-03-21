import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/auth/data/data_sources/auth_data_source.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/data/data_sources/firestore_data_source.dart';
import '../../../core/utilities/api_paths.dart';
import '../../../core/utilities/errors/exceptions.dart';
import '../../../core/utilities/errors/failures.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource ds;
  final FirestoreDataSource firestoreDs;

  AuthRepositoryImpl({required this.ds, required this.firestoreDs});

  @override
  Future<Either<Failure, User?>> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      final user = await ds.loginWithEmailAndPassword(email, password);
      return Right(user);
    } on AuthException catch (e) {
      return Left(FirebaseAuthFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, User?>> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      final user = await ds.signUpWithEmailAndPassword(email, password);
      return Right(user);
    } on AuthException catch (e) {
      return Left(FirebaseAuthFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, void>> assignUserData(
      String uid, Map<String, dynamic> data) async {
    try {
      await firestoreDs.setData(path: ApiPaths.userPath(uid), data: data);
      return const Right(Unit);
    } on AuthException catch (e) {
      return Left(FirebaseAuthFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, User?>> signInGoogle() async {
    try {
      final user = await ds.signInGoogle();
      return Right(user);
    } on AuthException catch (e) {
      return Left(FirebaseAuthFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, void>> forgotPassword(String email) async {
    try {
      return Right(ds.forgotPassword(email));
    } on AuthException catch (e) {
      return Left(FirebaseAuthFailure(message: e.message));
    }
  }
}
