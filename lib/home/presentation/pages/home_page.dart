import 'package:e_commerce_app/home/domain/models/product.dart';
import 'package:e_commerce_app/home/presentation/controllers/home_bloc.dart';
import 'package:e_commerce_app/home/presentation/widgets/list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utilities/assets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeSuccess) {
          print(state.saleProductList);
          print(state.newProductList);
        }
        return Scaffold(
          body: ListView(
            children: [
              Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Image.network(Assets.homePage,
                      width: double.infinity,
                      height: size.height * 0.3,
                      fit: BoxFit.cover),
                  Opacity(
                      opacity: .3,
                      child: Container(
                        width: double.infinity,
                        height: size.height * 0.3,
                        color: Colors.black,
                      )),
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text("Street Clothes",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            )),
                  )
                ],
              ),
              SizedBox(height: 24.0),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: ListHeader(
                      title: "Sale",
                      description: "Super Summer Sale",
                      onTap: () {})),
              SizedBox(height: 0.8),
              (state is HomeSuccess)
                  ? SizedBox(
                      width: size.width,
                      height: size.height * .45,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: state.saleProductList
                            .map((e) => Padding(
                                  padding: EdgeInsets.all(24),
                                  child: ListItem(product: e),
                                ))
                            .toList(),
                      ),
                    )
                  : Container(),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: ListHeader(
                      title: "New",
                      description: "Super New Products",
                      onTap: () {})),
              SizedBox(height: 0.8),
              (state is HomeSuccess)
                  ? SizedBox(
                      width: size.width,
                      height: size.height * .45,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: state.newProductList
                            .map((e) => Padding(
                                  padding: EdgeInsets.all(24),
                                  child: ListItem(product: e),
                                ))
                            .toList(),
                      ),
                    )
                  : Container(),
            ],
          ),
        );
      },
    );
  }
}

class ListHeader extends StatelessWidget {
  final String title;
  final String description;
  VoidCallback onTap;

  ListHeader(
      {super.key,
      required this.title,
      required this.description,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                fontWeight: FontWeight.bold, color: Colors.black)),
        Text(description,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(fontWeight: FontWeight.bold, color: Colors.grey))
      ],
    );
  }
}
