import 'package:dartz/dartz.dart';

import '../../../core/utilities/errors/failures.dart';
import '../models/order.dart';
import '../repository/cart_repository.dart';

class AddOrderUseCase {
  CartRepository repository;

  AddOrderUseCase({required this.repository});

  Future<Either<Failure, void>> call({required OrderModel order}) async {
    return await repository.addOrder(order: order);
  }
}
