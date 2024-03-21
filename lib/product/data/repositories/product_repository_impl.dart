import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/utilities/errors/failures.dart';

import '../../../core/data/data_sources/firestore_data_source.dart';
import '../../../core/utilities/api_paths.dart';
import '../../../core/utilities/errors/exceptions.dart';
import '../../domain/models/product.dart';
import '../../domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  FirestoreDataSource ds;

  ProductRepositoryImpl({required this.ds});

  @override
  Future<Either<Failure, List<Product>>> getNewProducts(
      {required String path,
      required Product Function(Map<String, dynamic>? data, String docId)
          builder}) async {
    try {
      final stream = ds.collectionsStream(
        path: ApiPaths.products,
        builder: (data, documentId) => Product.fromMap(data!, documentId),
      );
      return stream.first.then((value) => Right(value));
    } on FirestoreException catch (e) {
      return Left(FirebaseFirestoreFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getSaleProducts(
      {required String path,
      required Product Function(Map<String, dynamic>? data, String docId)
          builder}) async {
    try {
      final stream = await ds.collectionsStream(
          path: ApiPaths.products,
          builder: (data, documentId) => Product.fromMap(data!, documentId),
          queryBuilder: (query) => query.where('discountValue', isNotEqualTo: 0),);
      return stream.first.then((value) => Right(value));
    } on FirestoreException catch (e) {
      return Left(FirebaseFirestoreFailure(message: e.message));
    }
  }
}
