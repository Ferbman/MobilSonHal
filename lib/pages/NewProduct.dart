import 'package:flutter/material.dart';
import 'package:zirtavat/widgets/CartAppBar.dart';
import 'package:zirtavat/widgets/NewItemCard.dart';

class NewProductPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: NeverScrollableScrollPhysics(),
        children: [
          EasyAppBar(),
          Container(
            height: 800,
            padding: EdgeInsets.only(top: 15),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 213, 215, 220),
            ),
            child: Column(
              children: [
                newItem(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
