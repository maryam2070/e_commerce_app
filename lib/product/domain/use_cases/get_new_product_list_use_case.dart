import 'package:dartz/dartz.dart';

import '../../../core/utilities/api_paths.dart';
import '../../../core/utilities/errors/failures.dart';
import '../models/product.dart';
import '../repositories/product_repository.dart';

class GetNewProductListUseCase {
  ProductRepository repository;

  GetNewProductListUseCase({required this.repository});

  Future<Either<Failure, List<Product>>> call() {
    return repository.getNewProducts(
        path: ApiPaths.products,
        builder: (data, documentId) => Product.fromMap(data!, documentId));
  }
}
