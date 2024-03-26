import 'package:e_commerce_app/core/presentation/pages/order_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cart/domain/models/order.dart';
import '../controllers/cart_controller/cart_bloc.dart';

class OrderPage extends StatelessWidget {
  OrderPage({super.key});

  List<OrderModel> orders = [];
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CartBloc>(context).add(GetOrdersEvent());

    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * .1,
              ),
              Text("My Orders",
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge
                      ?.copyWith(fontWeight: FontWeight.w600)),
              Expanded(
                  child: MyCustomTab(
              ))
            ]),
      ),
    );
  }
}

class MyCustomTab extends StatefulWidget {
  MyCustomTab({ super.key});

  @override
  State<MyCustomTab> createState() => _MyCustomTabState();
}

class _MyCustomTabState extends State<MyCustomTab> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        return DefaultTabController(
          length: 3,
          child: Column(
            children: [
              TabBar(
                labelColor: Theme.of(context).primaryColor,
                indicatorColor: Theme.of(context).primaryColor,
                tabs: [
                  Tab(text: "Pending"),
                  Tab(text: "Delivered"),
                  Tab(text: "Canceled"),
                ],
              ),
              Expanded(
                child:(state is GetOrdersSuccess)? TabBarView(children: [
                  
                  OrdersListView(orders: state.orders.where((element) => element.status==OrderStatus.parser(OrderStatus.PENDING))),

                  OrdersListView(orders: state.orders.where((element) => element.status==OrderStatus.parser(OrderStatus.DELIVERED))),
                  OrdersListView(orders: state.orders.where((element) => element.status==OrderStatus.parser(OrderStatus.CANCELLED)))
                ]): Container(),
              )
            ],
          ),
        );
      },
    );
  }
}

class OrdersListView extends StatelessWidget {
  final Iterable<OrderModel> orders;
  const OrdersListView({required this.orders, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: orders.map((e) => OrderListItem(order: e,)).toList(),
    );
  }
}

class OrderListItem extends StatelessWidget {
  final OrderModel order;
  const OrderListItem({required this.order, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text("Order ${order.id}",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontWeight: FontWeight.w600)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Quantity ",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: CupertinoColors.inactiveGray)),
                  Text("${order.models.length}",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: CupertinoColors.inactiveGray)),
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
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: CupertinoColors.inactiveGray)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  OrderDetails(order: order,),)
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Details"),
                      )),
                  Text(order.status,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: CupertinoColors.activeGreen)),
                ],
              )
            ],
          ),
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
