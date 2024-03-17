import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/home/domain/repositories/home_repository.dart';

import '../../../core/utilities/api_paths.dart';
import '../../../core/utilities/errors/failures.dart';
import '../models/product.dart';

class GetNewProductListUseCase {
  HomeRepository repository;

  GetNewProductListUseCase({required this.repository});

  Future<Either<Failure, List<Product>>> call() {
    return repository.getNewProducts(
        path: ApiPaths.products,
        builder: (data, documentId) => Product.fromMap(data!, documentId));
  }
}
