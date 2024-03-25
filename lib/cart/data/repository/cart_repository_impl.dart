import 'package:dartz/dartz.dart';

import 'package:e_commerce_app/cart/domain/models/add_to_cart_model.dart';

import 'package:e_commerce_app/core/utilities/errors/failures.dart';

import '../../../auth/data/data_sources/auth_data_source.dart';
import '../../../core/data/data_sources/firestore_data_source.dart';
import '../../../core/utilities/api_paths.dart';
import '../../../core/utilities/errors/exceptions.dart';
import '../../domain/repository/cart_repository.dart';

class CartRepositoryImpl extends CartRepository {
  FirestoreDataSource ds;
  AuthDataSource authDs;

  CartRepositoryImpl({required this.ds, required this.authDs});

  @override
  Future<Either<Failure, void>> addToCart(
      {required AddToCartModel addToCartModel}) async {
    try {
      final id = DateTime.now().toString();
      final response = ds.setData(
          path: ApiPaths.cartProducts("authDs.currentUser!.uid") + '/' + id,
          data: addToCartModel.copyWith(id: id).toMap());

      await response.then((value) {
        if (value)
          return Right(Unit);
        else {
          return Left(FirebaseFirestoreFailure(message: "e.message"));
        }
      });
      return Right(Unit);
    } on FirestoreException catch (e) {
      return Left(FirebaseFirestoreFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<AddToCartModel>>> getCartModels(
      {required AddToCartModel Function(
              Map<String, dynamic>? data, String docId)
          builder}) async {
    try {
      final stream = ds.collectionsStream(
        path: ApiPaths.cartProducts("authDs.currentUser!.uid"),
        builder: (data, documentId) =>
            AddToCartModel.fromMap(data!, documentId),
      );
      return stream.first.then((value) => Right(value));
    } on FirestoreException catch (e) {
      return Left(FirebaseFirestoreFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, void>> deleteFromCart({required String id})async {
    try {
      final response = ds.deleteData(ApiPaths.cartProducts("authDs.currentUser!.uid")+'/${id}');
      await response.then((value) {
        if (value)
          return Right(Unit);
        else {
          return Left(FirebaseFirestoreFailure(message: "e.message"));
        }
      });

      return Right(Unit);
    } on FirestoreException catch (e) {
      return Left(FirebaseFirestoreFailure(message: e.message));
    }
  }
}
