import 'package:e_commerce_app/auth/presentation/widgets/main_button.dart';
import 'package:e_commerce_app/cart/domain/models/order.dart';
import 'package:e_commerce_app/core/presentation/pages/add_shipping_address.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cart/domain/models/add_to_cart_model.dart';
import '../../../core/utilities/assets.dart';
import '../controllers/cart_controller/cart_bloc.dart';

String address = "";
String name = "";
String card = "";

class CheckOutPage extends StatelessWidget {
  List<AddToCartModel> models;
  CheckOutPage({required this.models, super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              elevation: 3,
              backgroundColor: Colors.white,
              title: const Text("Checkout"),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const BoldTitle(title: "Shipping address"),
                      SizedBox(height: size.height * .01),
                      AddressBox(),
                      SizedBox(height: size.height * .03),
                      BoldTitle(title: "Payment"),
                      SizedBox(height: size.height * .01),
                      PaymentBox(),
                      SizedBox(height: size.height * .03),
                      TitleAndValue(
                        title: "order",
                        value: "${sum(models.map((e) => e.price))}\$",
                      ),
                      SizedBox(height: size.height * .01),
                      TitleAndValue(
                        title: "delivery",
                        value: "30\$",
                      ),
                      SizedBox(height: size.height * .01),
                      TitleAndValue(
                        title: "total",
                        value: "${sum(models.map((e) => e.price)) + 30}\$",
                      ),
                      SizedBox(height: size.height * .03),
                      MainButton(
                          ontap: () {
                            BlocProvider.of<CartBloc>(context).add(
                                AddOrderEvent(
                                    order: OrderModel(
                                        id: '',
                                        fullName: name,
                                        address: address,
                                        payment: card,
                                        deliveryTaxes: 30,
                                        orderPrice: double.parse(
                                            sum(models.map((e) => e.price))
                                                .toString()),
                                        models: models,
                                        status: OrderStatus.parser(
                                            OrderStatus.PENDING))));
                          },
                          text: "SUBMIT ORDER")
                    ]),
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

class AddressBox extends StatefulWidget {
  AddressBox({super.key});

  @override
  State<AddressBox> createState() => _AddressBoxState();
}

class _AddressBoxState extends State<AddressBox> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return DecoratedBox(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.white),
      child: Padding(
          padding: EdgeInsets.all(size.width * .02),
          child: (name == "")
              ? GestureDetector(
                  onTap: () async {
                    final List<String> result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddShippingAddress()),
                    );
                    setState(() {
                      name = result[0];
                      address = result[1];
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Add data",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontWeight: FontWeight.bold)),
                      Icon(
                        Icons.add,
                        color: Theme.of(context).primaryColor,
                      )
                    ],
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(name,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontWeight: FontWeight.bold)),
                        ChangeClickableText(onTap: () async {
                          final List<String> result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const AddShippingAddress()),
                          );
                          setState(() {
                            name = result[0];
                            address = result[1];
                          });
                        }),
                      ],
                    ),
                    SizedBox(
                      height: size.height * .02,
                    ),
                    Text(address,
                        style: Theme.of(context).textTheme.bodyMedium),
                  ],
                )),
    );
  }
}

class PaymentBox extends StatefulWidget {
  PaymentBox({super.key});

  @override
  State<PaymentBox> createState() => _PaymentBoxState();
}

class _PaymentBoxState extends State<PaymentBox> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _cardController = TextEditingController();
    return SizedBox(
      child: DecoratedBox(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.white),
        child: Padding(
          padding: EdgeInsets.all(size.width * .02),
          child: (card == "")
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Add data",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontWeight: FontWeight.bold)),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Padding(
                              padding: const EdgeInsets.all(40.0),
                              child: Wrap(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                        controller: _cardController,
                                        onEditingComplete: () {},
                                        textInputAction: TextInputAction.next,
                                        validator: (val) => val!.isEmpty
                                            ? 'Please enter your card'
                                            : null,
                                        decoration: const InputDecoration(
                                          labelText: "Card",
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: MainButton(
                                        ontap: () {
                                          setState(() {
                                            card = _cardController.text;
                                          });
                                        },
                                        text: "add"),
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Icon(
                        Icons.add,
                        color: Theme.of(context).primaryColor,
                      ),
                    )
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(card,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontWeight: FontWeight.bold)),
                    Spacer(),
                    ChangeClickableText(onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Padding(
                            padding: const EdgeInsets.all(40.0),
                            child: Wrap(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                      controller: _cardController,
                                      onEditingComplete: () {},
                                      textInputAction: TextInputAction.next,
                                      validator: (val) => val!.isEmpty
                                          ? 'Please enter your card'
                                          : null,
                                      decoration: const InputDecoration(
                                        labelText: "Card",
                                      )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: MainButton(
                                      ontap: () {
                                        setState(() {
                                          card = _cardController.text;
                                        });
                                      },
                                      text: "add"),
                                )
                              ],
                            ),
                          );
                        },
                      );
                    }),
                  ],
                ),
        ),
      ),
    );
  }
}

class ChangeClickableText extends StatelessWidget {
  final VoidCallback onTap;

  const ChangeClickableText({required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Text(
          "change",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold),
        ));
  }
}

class BoldTitle extends StatelessWidget {
  final String title;

  const BoldTitle({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context)
          .textTheme
          .headlineSmall
          ?.copyWith(fontWeight: FontWeight.bold),
    );
  }
}

class DeliveryItem extends StatelessWidget {
  final String img;
  final String name;

  const DeliveryItem({required this.img, required this.name, super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        child: DecoratedBox(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.white),
          child: Padding(
              padding: EdgeInsets.all(size.width * .02),
              child: Column(
                children: [
                  SizedBox(
                    width: size.width * .1,
                    height: size.height * .1,
                    child: Image.network(img),
                  ),
                  Text(name)
                ],
              )),
        ),
      ),
    );
  }
}

class TitleAndValue extends StatelessWidget {
  final String title;
  final String value;

  const TitleAndValue({required this.title, required this.value, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.grey[700],
                )),
        Text(
          value,
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
