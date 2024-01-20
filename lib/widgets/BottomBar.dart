import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MySimpleNavbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GNav(
      color: Colors.black,
      activeColor: Colors.green,
      onTabChange: (index) {
        switch (index) {
          case 0:
            Navigator.pushNamed(context, "cartPage");
            break;

          case 1:
            Navigator.pushNamed(context, "homePage");
            break;
          case 2:
            Navigator.pushNamed(context, "profilePage");
            break;
        }
      },
      tabs: const [
        GButton(icon: Icons.shopping_bag_outlined),
        GButton(icon: Icons.explore_outlined),
        GButton(icon: Icons.person_outline_sharp),
      ],
    );
  }
}
