import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/cart/domain/models/add_to_cart_model.dart';

import '../../../core/utilities/errors/failures.dart';
import '../repository/cart_repository.dart';

class GetCartUseCase {
  CartRepository repository;

  GetCartUseCase({required this.repository});

  Future<Either<Failure, List<AddToCartModel>>> call() {
    return repository.getCartModels(
        builder: (data, documentId) => AddToCartModel.fromMap(data!, documentId));
  }
}