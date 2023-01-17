import 'dart:convert';

import 'package:eportfolio/login.dart';
import 'package:eportfolio/view/friend/friend_profile.dart';
import 'package:eportfolio/view/home.dart';
import 'package:eportfolio/view/profile.dart';
import 'package:eportfolio/widgets/open_feed/article_card_open.dart';
import 'package:eportfolio/widgets/update_page/user_profile_edit.dart';
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
    return jwt;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    final storage = FlutterSecureStorage();
    var jwt = storage.read(key: 'jwt');

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/editUser' : (context) => EditUserProfile(),
        '/login' : (context) => Login(),
        '/home' : (context) => HomePage(0),
        '/friendprofile':(context) => FriendProfilePage(),
        '/profile':(context) => HomePage(2),
        '/openArticle':(context) => ArticleCardOpen(),
      },

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
                return HomePage(0);
              }
            } else {
              return Login();
            }
          }
      ),
    );
  }
}