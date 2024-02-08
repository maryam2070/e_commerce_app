import 'package:e_commerce_app/auth/presentation/widgets/main_button.dart';
import 'package:e_commerce_app/home/domain/models/product.dart';
import 'package:flutter/material.dart';

import '../widgets/drop_down_menu.dart';

class ProductDetails extends StatefulWidget {
  final Product product;

  const ProductDetails({required this.product});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool isFav = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.title,
            style: Theme.of(context).textTheme.bodyMedium),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                //todo
              },
              icon: Icon(Icons.share))
        ],
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
                            onChanged: (String? value) {},
                            items: const ["xs", "s", "m", "l", "xl", "xxl"],
                            hint: "size"),
                      )),
                      Spacer(),
                      Expanded(
                        child: SizedBox(
                          child: DropDownMenuComponent(
                              onChanged: (String? value) {},
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
                    child: Text("deeeeeeeesssssssscptionnnnnnnnnn",
                        //"\$${"widget.product.description"}",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold, color: Colors.grey)),
                  ),
                  const SizedBox(height: 16),
                  MainButton(
                      ontap: () {
                        //todo
                      },
                      text: "Add To Cart")
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
