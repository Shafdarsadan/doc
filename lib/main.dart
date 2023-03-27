import 'package:doc/checkup.dart';
import 'package:doc/helper/helper.dart';
import 'package:doc/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'loginScreen.dart';
import 'userregister.dart';
import 'profileScreen.dart';
import 'home_page.dart';
import 'updateprofile.dart';


void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _helper = Helper();

  bool isuserloggedin = false;

  @override
  void initState() {
    // TODO: implement initState
    init();
    super.initState();


  }
  void init()async{
      final result = await _helper.isUsersigned();
      if(result == true){
        final usercred = await _helper.getUserCredentials();
        print("userlogin email : ${usercred!.email}");

      }
      setState(() {
        print("userlogin status : ${result}");


        isuserloggedin = result;
      });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Find Doc',
      debugShowCheckedModeBanner: false,
      home: isuserloggedin?Home(): LoginScreen(),

    );
  }
}