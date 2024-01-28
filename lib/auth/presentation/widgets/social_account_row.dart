import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SocialAccountsRow extends StatelessWidget {

  final String title;

  const SocialAccountsRow({super.key,required this.title});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
         Align(
          alignment: AlignmentDirectional.center,
          child: Text(title),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 80,
              height: 60,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.red),
              child: const Icon(Icons.add),
            ),
            Container(
              width: 80,
              height: 60,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.red),
              child: const Icon(Icons.add),
            )
          ],
        )
      ],
    );
  }
}
