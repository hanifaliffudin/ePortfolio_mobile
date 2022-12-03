import 'package:eportfolio/login.dart';
import 'package:eportfolio/view/home.dart';
import 'package:flutter/material.dart';

import 'register.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/register' : (context) => const Register(),
        //'/' : (context) => const Login(),
        '/' : (context) => const HomePage(),
      },
      // initialRoute: '/',
      // routes: {
      //   HomePage.routeName: (context) => const HomePage(),
      //   DiscoverPage.routeName: (context) => const DiscoverPage(),
      //   ProfilePage.routeName: (context) => const ProfilePage(),
      // },
    );
  }
}