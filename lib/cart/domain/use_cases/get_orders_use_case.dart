import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/cart/domain/models/order.dart';

import '../../../core/utilities/errors/failures.dart';
import '../repository/cart_repository.dart';

class GetOrdersUseCase {
  CartRepository repository;

  GetOrdersUseCase({required this.repository});

  Future<Either<Failure, List<OrderModel>>> call() {
    return repository.getOrders(
        builder: (data, documentId) => OrderModel.fromJson(data!));
  }
}
