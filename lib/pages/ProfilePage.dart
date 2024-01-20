import 'package:flutter/material.dart';

import 'package:zirtavat/widgets/ProfileCard.dart';
import 'package:zirtavat/widgets/ProfileSection.dart';

import '../widgets/CartAppBar.dart';

class ProfilePage extends StatelessWidget {
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
                Container(
                  padding: EdgeInsets.only(left: 40),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Profilim",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ),
                ProfileCart(),
                ProfileSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
