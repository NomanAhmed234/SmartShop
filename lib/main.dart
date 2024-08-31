import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sneaker_shoes_app/customNavigationBar.dart';
import 'package:sneaker_shoes_app/favorite_screen.dart';
import 'package:sneaker_shoes_app/firebase_options.dart';
import 'package:sneaker_shoes_app/home_screen.dart';
import 'package:sneaker_shoes_app/profile_screen.dart';
import 'package:sneaker_shoes_app/signup_screens/complete_profile_screen.dart';
import 'package:sneaker_shoes_app/signup_screens/confirm_password_screen.dart';
import 'package:sneaker_shoes_app/signup_screens/forget_password_screen.dart';
import 'package:sneaker_shoes_app/signup_screens/signin_screen.dart';
import 'package:sneaker_shoes_app/signup_screens/signup_register_account_screen.dart';
import 'product_list_screen.dart';

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
      title: 'Product App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}
