import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/utilities/errors/failures.dart';
import 'package:e_commerce_app/home/domain/models/product.dart';

import '../../../core/utilities/api_paths.dart';
import '../../../core/utilities/errors/exceptions.dart';
import '../../../shared/data/data_sources/firestore_data_source.dart';
import '../../domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  FirestoreDataSource ds;

  HomeRepositoryImpl({required this.ds});

  @override
  Future<Either<Failure, Stream<List<Product>>>> getNewProducts(
      {required String path,
      required Product Function(Map<String, dynamic>? data, String docId)
          builder}) async {
    try {
      final stream = await ds.collectionsStream(
        path: ApiPaths.products,
        builder: (data, documentId) => Product.fromMap(data!, documentId),
        queryBuilder: (query) => query.where('discountValue', isNotEqualTo: 0),
      );
      return Right(stream);
    } on FirestoreException catch (e) {
      return Left(FirebaseFirestoreFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Stream<List<Product>>>> getSaleProducts(
      {required String path,
      required Product Function(Map<String, dynamic>? data, String docId)
          builder}) async {
    try {
      final stream = await ds.collectionsStream(
          path: ApiPaths.products,
          builder: (data, documentId) => Product.fromMap(data!, documentId));
      return Right(stream);
    } on FirestoreException catch (e) {
      return Left(FirebaseFirestoreFailure(message: e.message));
    }
  }
}
