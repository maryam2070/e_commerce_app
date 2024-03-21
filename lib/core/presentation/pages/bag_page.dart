import 'package:e_commerce_app/auth/presentation/widgets/main_button.dart';
import 'package:e_commerce_app/core/utilities/assets.dart';
import 'package:flutter/material.dart';

class BagPage extends StatelessWidget {
  const BagPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: size.height * .01),
                Text("My Bag",
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge
                        ?.copyWith(fontWeight: FontWeight.w600)),
                SizedBox(height: size.height * 0.03),
                // SizedBox(
                // width: double.infinity,
                // height: (size.height * .36) * dummyProducts.length,
                //   child:
                //   Column(
                //     children: dummyProducts.map((e) => Padding(
                //       padding: EdgeInsets.all(16),
                //       child: ListItem(),
                //     )).toList(),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total Amount",style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600
                      )),
                      Text("300\$" ,style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600
                      )),
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.05),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: MainButton(ontap: (){}, text: "CHECK OUT"),
                ),
                SizedBox(height: size.height * 0.04),
              ],
            ),
          ),
        ));
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

class ListItem extends StatelessWidget {
  const ListItem({super.key});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * .3,
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(Assets.tempProductAsset1),
            ),
            SizedBox(
              width: size.width * .01,
            ),
            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: size.height * .02,
                    ),
                    Text(
                      "T-shirt",
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: size.height * .02,
                    ),
                    Row(
                      children: [
                        TitleAndValue(
                            title: "color: ", value: " black"),
                        SizedBox(width: size.width * .01),
                        TitleAndValue(title: "color: ", value: " black")
                      ],
                    ),
                    SizedBox(height: size.height * .05),
                    Row(
                      children: [
                        _circleIcon(() {
                          //todo
                        }, Icons.add),
                        SizedBox(width: size.width * .03),
                        Text("1"),
                        SizedBox(width: size.width * .03),
                        _circleIcon(() {
                          //todo
                        }, Icons.remove)
                      ],
                    ),
                    SizedBox(
                      width: size.width * .01,
                    )
                  ],
                )),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        //todo
                      },
                      child: Icon(Icons.more_horiz),
                    ),
                    Text(
                      "\$50",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _circleIcon(VoidCallback onTap, IconData icon) => GestureDetector(
    onTap: onTap,
    child: DecoratedBox(
        decoration: BoxDecoration(shape: BoxShape.circle),
        child: Icon(icon)),
  );
}

