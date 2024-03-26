import 'package:e_commerce_app/auth/presentation/widgets/main_button.dart';
import 'package:e_commerce_app/cart/domain/models/add_to_cart_model.dart';
import 'package:e_commerce_app/core/presentation/pages/check_out_page.dart';
import 'package:e_commerce_app/core/utilities/assets.dart';
import 'package:e_commerce_app/core/utilities/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controllers/cart_controller/cart_bloc.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int totalAmount = 0;
  List<AddToCartModel> models = [];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    BlocProvider.of<CartBloc>(context).add(GetCartEvent());
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is GetCartSuccess) models = state.models;
        return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              actions: [
                InkWell(
                  onTap: () {
                    //todo
                  },
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Icon(Icons.search),
                  ),
                )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView(
                shrinkWrap: false,
                children: [
                  Text("My Cart",
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge
                          ?.copyWith(fontWeight: FontWeight.w600)),
                  (state is GetCartSuccess)
                      ? Column(
                          children: state.models
                              .map((e) => Padding(
                                    padding: EdgeInsets.symmetric(vertical: 16),
                                    child: CartListItem(model: e, canDelete: true,),
                                  ))
                              .toList(),
                        )
                      : Container(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total price",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(fontWeight: FontWeight.w600)),
                        Text(
                            (state is GetCartSuccess)
                                ? sum(state.models.map((e) => e.price))
                                        .toString() +
                                    "\$"
                                : "",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                  SizedBox(height: size.height * 0.05),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Builder(builder: (context) {
                      return MainButton(
                          ontap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      CheckOutPage(models: models)),
                            );
                          },
                          text: "CHECK OUT");
                    }),
                  ),
                  SizedBox(height: size.height * 0.04),
                ],
              ),
            ));
      },
    );
  }

  sum(Iterable<int> prices) {
    var s = 0;
    prices.forEach((element) {
      s += element;
    });
    return s;
  }
}

class TitleAndValue extends StatelessWidget {
  String title;
  String value;

  TitleAndValue({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(children: [
      TextSpan(children: [
        TextSpan(
            text: title,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: Colors.grey)),
        TextSpan(text: value, style: Theme.of(context).textTheme.bodyLarge)
      ])
    ]));
  }
}

class CartListItem extends StatelessWidget {
  final AddToCartModel model;
  bool canDelete;
  CartListItem({required this.canDelete,required this.model, super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return DecoratedBox(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: Colors.white),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: size.width * .3,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(model.imgUrl),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.height * .02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        model.title,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Text(
                    "\$ ${model.price}",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: size.height * .02,
                  ),
                  Column(
                    children: [
                      TitleAndValue(title: "color: ", value: " ${model.color}"),
                      SizedBox(width: size.width * .01),
                      TitleAndValue(title: "size: ", value: " ${model.size}")
                    ],
                  ),
                ],
              ),
              (canDelete==true)?Padding(
                padding: const EdgeInsets.all(18.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      BlocProvider.of<CartBloc>(context)
                          .add(DeleteFromCartEvent(id: model.id));
                    },
                    child: Icon(Icons.delete),
                  ),
                ),
              ):Container(),
            ],
          ),
        ],
      ),
    );
  }
}
