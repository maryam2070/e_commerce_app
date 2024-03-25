import 'package:e_commerce_app/auth/presentation/widgets/main_button.dart';
import 'package:e_commerce_app/cart/domain/models/add_to_cart_model.dart';
import 'package:e_commerce_app/core/presentation/controllers/cart_controller/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../product/domain/models/product.dart';
import '../widgets/drop_down_menu.dart';

class ProductDetails extends StatefulWidget {
  final Product product;

  const ProductDetails({required this.product});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool isFav = false;
  var sizeValue="";
  var colorValue="";
  var quantityValue=1;
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    return BlocBuilder<CartBloc, CartState>(
  builder: (context, state) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.title,
            style: Theme.of(context).textTheme.bodyMedium),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.network(
              widget.product.imgUrl,
              width: double.infinity,
              height: size.height * 0.5,
              fit: BoxFit.cover,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                          child: SizedBox(
                        child: DropDownMenuComponent(
                            onChanged: (String? value) {
                              sizeValue=value!;
                            },
                            items: const ["xs", "s", "m", "l", "xl", "xxl"],
                            hint: "size"),
                      )),
                      Spacer(),
                      Expanded(
                        child: SizedBox(
                          child: DropDownMenuComponent(
                              onChanged: (String? value) {
                                colorValue=value!;
                              },
                              items: const ["blue", "red", "black"],
                              hint: "color"),
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isFav = !isFav;
                          });
                        },
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                                color: Colors.white, shape: BoxShape.circle),
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                  isFav
                                      ? Icons.favorite_border
                                      : Icons.favorite,
                                  color: Colors.red[400]),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.product.title,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(fontWeight: FontWeight.bold)),
                      Text("\$${widget.product.price}",
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("${widget.product.category}",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold, color: Colors.grey)),
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("${widget.product.description}",
                        //"\$${"widget.product.description"}",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold, color: Colors.grey)),
                  ),
                  const SizedBox(height: 16),
                  //SizedBox(height: size.height * .05),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _circleIcon(() {
                          setState(() {
                            quantityValue++;
                          });
                        }, Icons.add),
                        SizedBox(width: size.width * .03),
                        Text('${quantityValue}'),
                        SizedBox(width: size.width * .03),
                        _circleIcon(() {
                          setState(() {
                            if(quantityValue!=1)quantityValue--;
                          });
                        }, Icons.remove)
                      ],
                    ),
                  ),
                  MainButton(
                      ontap: () {
                        BlocProvider.of<CartBloc>(context).add(AddToCartEvent(model:
                        AddToCartModel(id: '',
                            title: widget.product.title,
                            price: widget.product.price,
                            productId: widget.product.id,
                            imgUrl: widget.product.imgUrl,
                            size: sizeValue,
                            color:colorValue,
                            isChecked: false,
                            quantity: quantityValue,
                            discountValue: widget.product.discountValue!)));
                      },
                      text: "Add To Cart")
                ],
              ),
            )
          ],
        ),
      ),
    );
  },
);
  }
}

Widget _circleIcon(VoidCallback onTap, IconData icon) => GestureDetector(
  onTap: onTap,
  child: DecoratedBox(
      decoration: BoxDecoration(shape: BoxShape.circle),
      child: Icon(icon)),
);
