import 'package:flutter/material.dart';
import 'package:zirtavat/widgets/CartBottomBar.dart';
import '../widgets/CartAppBar.dart';
import '../widgets/CartItems.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          EasyAppBar(),
          Container(
            height: 700,
            padding: EdgeInsets.only(top: 15),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 213, 215, 220),
            ),
            child: Column(children: [
              Container(
                alignment: AlignmentDirectional.topStart,
                padding: EdgeInsets.only(left: 35),
                child: Text(
                  "Başvurularım",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
              CartItems(),
            ]),
          )
        ],
      ),
      bottomNavigationBar: CartBottomBar(),
    );
  }
}
