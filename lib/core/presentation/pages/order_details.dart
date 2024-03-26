import 'package:e_commerce_app/core/presentation/pages/cart_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cart/domain/models/order.dart';
import '../controllers/cart_controller/cart_bloc.dart';

class OrderDetails extends StatelessWidget {
  OrderModel order;
  OrderDetails({required this.order, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          InkWell(
            onTap: () {
              BlocProvider.of<CartBloc>(context)
                  .add(CancelOrderEvent(order: order));
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Icon(Icons.cancel_outlined),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 60),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text("Order ${order.id}",
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(fontWeight: FontWeight.w600)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Quantity ",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: CupertinoColors.inactiveGray)),
                Text("${order.models.length}",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w600)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total Amount ",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: CupertinoColors.inactiveGray)),
                Text("${sum(order.models.map((e) => e.price)) + 30}\$",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w600)),
              ],
            ),
            Column(
              children: order.models
                  .map((e) => Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 16),
                        child: CartListItem(
                          model: e,
                          canDelete: false,
                        ),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
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
