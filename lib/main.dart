import "package:flutter/material.dart";
import 'package:zirtavat/pages/CartPage.dart';

import 'package:zirtavat/pages/MyItems.dart';
import 'package:zirtavat/pages/login_screen.dart';
import 'package:zirtavat/pages/NewProduct.dart';
import 'package:zirtavat/pages/ProfilePage.dart';
import 'package:zirtavat/pages/RegisterPage.dart';
import './pages/Homepage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      routes: {
        "/": (context) => LoginScreen(),
        "cartPage": (context) => CartPage(),
        "homePage": (context) => HomePage(),
        "profilePage": (context) => ProfilePage(),
        "registerPage": (context) => RegisterPage(),
        "loginPage": (context) => LoginScreen(),
        "newProduct": (context) => NewProductPage(),
        "myItems": (context) => MyItems(),
      },
    );
  }
}
