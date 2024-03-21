import 'package:e_commerce_app/auth/presentation/widgets/main_button.dart';
import 'package:flutter/material.dart';

import '../../../core/utilities/assets.dart';

class CheckOutPage extends StatelessWidget {
  const CheckOutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const BoldTitle(title: "Shipping address"),
              SizedBox(height: size.height * .01),
              AddressBox(
                onTap: () {
                  //todo
                },
                name: "Maryam Amr",
                address: "prison realm  shebuya, jp",
              ),
              SizedBox(height: size.height * .03),
              BoldTitle(title: "Payment"),
              SizedBox(height: size.height * .01),
              PaymentBox(
                  card: "***** **** *** 123",
                  onTap: () {
                    //todo
                  }),
              SizedBox(height: size.height * .03),
              const BoldTitle(title: "Delivery methods"),
              SizedBox(height: size.height * .01),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  //todo chech scroll in phone
                  children: [
                    DeliveryItem(img: Assets.mastercardIcon, name: "dnfjnjn"),
                    DeliveryItem(img: Assets.mastercardIcon, name: "dnfjnjn"),
                    DeliveryItem(img: Assets.mastercardIcon, name: "dnfjnjn"),
                    DeliveryItem(img: Assets.mastercardIcon, name: "dnfjnjn"),
                  ],
                ),
              ),
              SizedBox(height: size.height * .03),
                  TitleAndValue(
                    title: "order",
                    value: "122\$",
                  ),
                  SizedBox(height: size.height * .01),
                  TitleAndValue(
                    title: "delivery",
                    value: "122\$",
                  ),
                  SizedBox(height: size.height * .01),
                  TitleAndValue(
                title: "total",
                value: "122\$",
              ),
                  SizedBox(height: size.height * .03),
                  MainButton(ontap: (){
                    //todo
                  }, text: "SUBMIT ORDER")
            ]),
          ),
        ));
  }
}

class AddressBox extends StatelessWidget {
  final VoidCallback onTap;
  final String name;
  final String address;

  const AddressBox(
      {required this.onTap,
      required this.name,
      required this.address,
      super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      child: DecoratedBox(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.white),
        child: Padding(
            padding: EdgeInsets.all(size.width * .02),
            child: Column(
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
                    ChangeClickableText(onTap: onTap),
                  ],
                ),
                SizedBox(
                  height: size.height * .02,
                ),
                Text(address, style: Theme.of(context).textTheme.bodyMedium),
              ],
            )),
      ),
    );
  }
}

class PaymentBox extends StatelessWidget {
  final VoidCallback onTap;
  final String card;

  const PaymentBox({required this.onTap, required this.card, super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      child: DecoratedBox(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.white),
        child: Padding(
          padding: EdgeInsets.all(size.width * .02),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: size.width * .07,
                height: size.height * .07,
                child: Image.network(Assets.mastercardIcon),
              ),
              Text(card,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.bold)),
              Spacer(),
              ChangeClickableText(onTap: onTap),
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
      children: [Text(title,style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.grey[700],)),
        Text(value,style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),)],
    );
  }
}
