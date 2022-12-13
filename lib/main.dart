import 'dart:convert';

import 'package:eportfolio/login.dart';
import 'package:eportfolio/view/home.dart';
import 'package:eportfolio/view/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'register.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final storage = new FlutterSecureStorage();

  Future<String> get jwtOrEmpty async {
    var jwt = await storage.read(key: "jwt");
    var userId = await storage.read(key: 'userId');
    if(jwt == null) return "";
    print('iniuserId $userId');
    return jwt;
  }


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
     /* routes: {
        '/register' : (context) => const Register(),
        '/' : (context) => const Login(),
        //'/home' : (context) => const HomePage(),
        'profile':(context) => const ProfilePage()
      },*/
      /*home: jwtOrEmpty()? Login() : HomePage(jwtOrEmpty),*/
      home: FutureBuilder(
          future: jwtOrEmpty,
          builder: (context, snapshot) {
            if(!snapshot.hasData) return CircularProgressIndicator();
            if(snapshot.data != "") {
              var str = snapshot.data;
              var jwt = str.toString().split(".");
              if(jwt.length !=3) {
                return Login();
              } else {
                return HomePage(jwt.toString());
                /*var payload = json.decode(ascii.decode(base64.decode(base64.normalize(jwt[1]))));*/
              }
            } else {
              return Login();
            }
          }
      ),
    );
  }
}