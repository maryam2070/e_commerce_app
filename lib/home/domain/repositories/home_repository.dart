import 'package:dartz/dartz.dart';

import '../../../core/utilities/errors/failures.dart';
import '../models/product.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<Product>>> getSaleProducts(
      {required String path,
        required Product Function(Map<String, dynamic>? data, String docId) builder});

  Future<Either<Failure, List<Product>>> getNewProducts(
      {required String path,
        required Product Function(Map<String, dynamic>? data, String docId) builder});
}
