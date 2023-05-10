import 'dart:convert';

import 'package:eportfolio/login.dart';
import 'package:eportfolio/view/add_articles.dart';
import 'package:eportfolio/badge/add_badges.dart';
import 'package:eportfolio/view/friend/friend_profile.dart';
import 'package:eportfolio/view/home.dart';
import 'package:eportfolio/view/profile.dart';
import 'package:eportfolio/view/video_player.dart';
import 'package:eportfolio/activity/activity_task.dart';
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
    if(jwt == null) return "";
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
      routes: {
        '/editUser' : (context) => EditUserProfile(),
        '/login' : (context) => Login(),
        '/home' : (context) => HomePage(0),
        '/friendprofile':(context) => FriendProfilePage(0),
        '/profile':(context) => HomePage(2),
        '/editArticle':(context) => AddArticles(),
        '/album' : (context) => ProfilePage(5),
        '/badge' : (context) => ProfilePage(4),
        '/activity' : (context) => ProfilePage(3),
        '/project' : (context) => ProfilePage(6),
        '/friendProject' : (context) => FriendProfilePage(6),
        '/addBadge' : (context) => AddBadges(),
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