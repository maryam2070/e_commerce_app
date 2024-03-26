class AddToCartModel {
  final String id;
  final String productId;
  final String title;
  final int price;
  final int quantity;
  final String imgUrl;
  final int discountValue;
  final String color;
  final String size;
  final bool isChecked;

  AddToCartModel({
    required this.id,
    required this.title,
    required this.price,
    required this.productId,
    required this.quantity ,
    required this.imgUrl,
    required this.discountValue ,
    required this.color ,
    required this.size,
    required this.isChecked
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    result.addAll({'id': id});
    result.addAll({'productId': productId});
    result.addAll({'title': title});
    result.addAll({'price': price});
    result.addAll({'quantity': quantity});
    result.addAll({'imgUrl': imgUrl});
    result.addAll({'discountValue': discountValue});
    result.addAll({'color': color});
    result.addAll({'size': size});
    result.addAll({'isChecked': isChecked});

    return result;
  }

  factory AddToCartModel.fromMap(Map<String, dynamic> map) {
    return AddToCartModel(
      id: map['id'],
      title: map['title'] ?? '',
      productId: map['productId'] ?? '',
      price: map['price']?.toInt() ?? 0,
      quantity: map['quantity']?.toInt() ?? 0,
      imgUrl: map['imgUrl'] ?? '',
      discountValue: map['discountValue']?.toInt() ?? 0,
      color: map['color'] ?? '',
      size: map['size'] ?? '',
      isChecked: map['isChecked'] ?? '',
    );
  }

  AddToCartModel copyWith({
    String? id,
    String? productId,
    String? title,
    int? price,
    int? quantity,
    String? imgUrl,
    int? discountValue,
    String? color,
    String? size,
    bool? isChecked,
  }) {
    return AddToCartModel(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      title: title ?? this.title,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      imgUrl: imgUrl ?? this.imgUrl,
      discountValue: discountValue ?? this.discountValue,
      color: color ?? this.color,
      size: size ?? this.size,
      isChecked: isChecked ?? this.isChecked,
    );
  }
}
