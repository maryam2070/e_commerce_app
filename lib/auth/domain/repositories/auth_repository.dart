import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart';

import '../../../core/utilities/errors/failures.dart';

abstract class AuthRepository{
  Future<Either<Failure,User?>> loginWithEmailAndPassword(String email,String password);
  Future<Either<Failure,User?>> signUpWithEmailAndPassword(String email,String password);
  Future<Either<Failure,User?>> signInGoogle();
  Future<Either<Failure,void>> assignUserData(String uid, Map<String,dynamic> data);
  Future<Either<Failure,void>> forgotPassword(String email);
 // Future<Either<Failure,User?>> authStateChange();
 // Future<Either<Failure,User?>> signUpWithEmailAndPassword(String email,String password);
}