import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/cart/domain/models/add_to_cart_model.dart';

import '../../../core/utilities/errors/failures.dart';

abstract class CartRepository {
  Future<Either<Failure, void>> addToCart(
      {required AddToCartModel addToCartModel});
  Future<Either<Failure, void>> deleteFromCart({required String id});
  Future<Either<Failure, List<AddToCartModel>>> getCartModels(
      {required AddToCartModel Function(
              Map<String, dynamic>? data, String docId)
          builder});
}
