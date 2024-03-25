import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/cart/domain/models/add_to_cart_model.dart';

import '../../../core/utilities/errors/failures.dart';
import '../repository/cart_repository.dart';

class AddToCartUseCase {
  CartRepository repository;

  AddToCartUseCase({required this.repository});

  Future<Either<Failure, void>> call({required AddToCartModel model}) async {
    return await repository.addToCart(addToCartModel: model);
  }
}
