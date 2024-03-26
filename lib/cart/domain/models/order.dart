import 'dart:convert';

import 'add_to_cart_model.dart';

class OrderModel {
  String id;
  String fullName;
  String address;
  String payment;
  double deliveryTaxes;
  double orderPrice;
  List<AddToCartModel> models;
  String status;

  OrderModel(
      {required this.id,
      required this.fullName,
      required this.address,
      required this.payment,
      required this.deliveryTaxes,
      required this.orderPrice,
      required this.models,
      required this.status});

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json["id"],
      fullName: json["fullName"],
      address: json["address"],
      payment: json["payment"],
      deliveryTaxes: json["deliveryTaxes"],
      orderPrice: json["orderPrice"],
      models: List.of(json["models"])
          .map((i) => AddToCartModel.fromMap(i))
          .toList(),
      status: json["status"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "fullName": this.fullName,
      "address": this.address,
      "payment": this.payment,
      "deliveryTaxes": this.deliveryTaxes,
      "orderPrice": this.orderPrice,
      "models": this.models.map((e) => e.toMap()),
      "status": this.status,
    };
  }

  OrderModel copyWith({
    String? id,
    String? fullName,
    String? address,
    String? payment,
    double? deliveryTaxes,
    double? orderPrice,
    List<AddToCartModel>? models,
    String? status,
  }) {
    return OrderModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      address: address ?? this.address,
      payment: payment ?? this.payment,
      deliveryTaxes: deliveryTaxes ?? this.deliveryTaxes,
      orderPrice: orderPrice ?? this.orderPrice,
      models: models ?? this.models,
      status: status ?? this.status,
    );
  }
}

enum OrderStatus {
  DELIVERED, CANCELLED, PENDING ;

  static String parser(OrderStatus status){
    if(status == DELIVERED){
      return "Delivered";
    }
    if(status == CANCELLED){
      return "Cancelled";
    }
    return "Pending";
  }
}
