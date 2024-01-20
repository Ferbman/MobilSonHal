import 'package:flutter/material.dart';
import 'package:zirtavat/widgets/CatagoriesWidget.dart';
import '../widgets/ItemWidgets.dart';
import '../widgets/HomeAppBar.dart';
import '../widgets/MainbannerItems.dart';
import '../widgets/BottomBar.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          HomeAppBar(),
          Container(
            padding: EdgeInsets.only(top: 15),
            decoration:
                BoxDecoration(color: Color.fromARGB(255, 213, 215, 220)),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.38),
                  ),
                  child: Row(
                    children: [
                      Text(
                        "En Çok Görüntülenenler",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.green,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ),
                      Container()
                    ],
                  ),
                ),
                MainBannerItems(),
                /*Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  child: Text(
                    "Katagoriler",
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600,
                      color: Colors.green,
                      fontSize: 20,
                    ),
                  ),
                ),
                CatagoriesWidget(),*/
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  child: Text(
                    "Ürünler",
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: Colors.green,
                    ),
                  ),
                ),
                ItemsWidget(),
                Container(
                  height: 200,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: MySimpleNavbar(),
    );
  }
}
