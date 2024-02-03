import 'package:e_commerce_app/home/domain/models/product.dart';
import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  Product product;

  ListItem({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 100,
        child: DecoratedBox(
            decoration: BoxDecoration(),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(product.imgUrl,
                        width: 200, height: 200, fit: BoxFit.cover),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 30,
                      width: 50,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            color: Colors.red[400],
                            borderRadius: BorderRadius.circular(16)),
                        child: Center(
                            child: Text("${product.discountValue}%",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(color: Colors.white))),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: .8),
              Text(
                product.category,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: Colors.grey[500]),
              ),
              const SizedBox(height: .6),
              Text(
                product.title,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: .6),
              Text.rich(TextSpan(children: [
                TextSpan(
                    text: "${product.price}\$",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[500],
                        decoration: TextDecoration.lineThrough)),
                TextSpan(
                    text: " ${product.price * (product.discountValue) / 100}\$",
                    style: Theme.of(context).textTheme.bodyMedium)
              ]))
            ])));
  }
}
