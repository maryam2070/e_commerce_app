import 'package:e_commerce_app/core/utilities/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../product/domain/models/product.dart';

class ListItem extends StatelessWidget {
  Product product;

  ListItem({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context, rootNavigator: true)
            .pushNamed(AppRoutes.productDetailsRoute, arguments: product);
      },
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(product.imgUrl,
                      width: 200, height: 200, fit: BoxFit.cover),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        color: (product.discountValue!=0)?Colors.red[400]:Colors.black,
                        borderRadius: BorderRadius.circular(16)),
                    child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text((product.discountValue!=0)? "${product.discountValue}%":"New",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: Colors.white)),
                        )),
                  ),
                )
              ],
            ),
            const SizedBox(height: .8),
            RatingBarIndicator(
              itemSize: 20,
              rating: product.rate?? 0.0,
              direction: Axis.horizontal,
              itemPadding: EdgeInsets.all(2),
              itemBuilder: (BuildContext context, _) => Icon(
                Icons.star,
                color: Colors.yellow[400],
              ),
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
            (product.discountValue!=0)?Text.rich(TextSpan(children: [
              TextSpan(
                  text: "${product.price}\$",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(
                          color: Colors.grey[500],
                          decoration: TextDecoration.lineThrough)),
              if (product.discountValue != null) //todo
                TextSpan(
                    text:
                        " ${product.price * (product.discountValue!) / 100}\$",
                    style: Theme.of(context).textTheme.bodyMedium)
            ])):Text(" ${product.price}\$",
                style: Theme.of(context).textTheme.bodyMedium)
          ]),
    );
  }
}
