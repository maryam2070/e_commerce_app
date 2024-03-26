import 'package:dartz/dartz.dart';

import '../../../core/utilities/errors/failures.dart';
import '../repository/cart_repository.dart';

class DeleteFromCartUseCase {
  CartRepository repository;

  DeleteFromCartUseCase({required this.repository});

  Future<Either<Failure, void>> call({required String id}) async {
    return await repository.deleteFromCart(id: id);
  }
}
