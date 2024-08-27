import 'package:flutter/material.dart';
import 'package:sneaker_shoes_app/customNavigationBar.dart';
import 'package:sneaker_shoes_app/favorite_screen.dart';
import 'package:sneaker_shoes_app/home_screen.dart';
import 'package:sneaker_shoes_app/profile_screen.dart';
import 'product_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BottomNavScreen(),
    );
  }
}
