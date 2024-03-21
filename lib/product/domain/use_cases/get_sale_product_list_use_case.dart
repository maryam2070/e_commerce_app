import 'package:dartz/dartz.dart';

import '../../../core/utilities/api_paths.dart';
import '../../../core/utilities/errors/failures.dart';
import '../models/product.dart';
import '../repositories/product_repository.dart';

class GetSaleProductListUseCase {
  ProductRepository repository;

  GetSaleProductListUseCase({required this.repository});

  Future<Either<Failure, List<Product>>> call() {
    return repository.getSaleProducts(
        path: ApiPaths.products,
        builder: (data, documentId) => Product.fromMap(data!, documentId));
  }
}
