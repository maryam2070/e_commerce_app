import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/cart/domain/models/add_to_cart_model.dart';
import 'package:e_commerce_app/cart/domain/models/order.dart';

import '../../../core/utilities/errors/failures.dart';

abstract class CartRepository {
  Future<Either<Failure, void>> addToCart(
      {required AddToCartModel addToCartModel});

  Future<Either<Failure, void>> deleteFromCart({required String id});

  Future<Either<Failure, List<AddToCartModel>>> getCartModels(
      {required AddToCartModel Function(Map<String, dynamic>? data) builder});

  Future<Either<Failure, void>> addOrder({required OrderModel order});

  Future<Either<Failure, List<OrderModel>>> getOrders(
      {required OrderModel Function(Map<String, dynamic>? data, String docId)
          builder});

  Future<Either<Failure, void>> cancelOrder({required OrderModel order});
}
