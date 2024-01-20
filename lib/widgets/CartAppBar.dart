import 'package:flutter/material.dart';

class EasyAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 213, 215, 220),
      padding: EdgeInsets.all(25),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_sharp,
              size: 30,
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }
}
