import 'package:doc/checkup.dart';
import 'package:doc/home_page.dart';
import 'package:flutter/material.dart';
import 'loginScreen.dart';
import 'userregister.dart';
import 'profileScreen.dart';
import 'home_page.dart';
import 'updateprofile.dart';


void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Find Doc',
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),

    );
  }
}