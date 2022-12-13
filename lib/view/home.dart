import 'dart:convert';

import 'package:eportfolio/view/discover.dart';
import 'package:eportfolio/view/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../widgets/box_add_post.dart';
import '../widgets/card/post_feed.dart';
import 'package:http/http.dart' as http;
import '../widgets/custom_appBar.dart';
import 'feeds.dart';

class HomePage extends StatefulWidget {
  /*const HomePage({Key? key}) : super(key: key);*/
  HomePage(this.jwt);

  /*factory HomePage.fromBase64(String jwt) =>
      HomePage(
          jwt,
          json.decode(
              ascii.decode(
                  base64.decode(base64.normalize(jwt.split(".")[1]))
              )
          )
      );*/

  final String jwt;
  /*final Map<String, dynamic> payload;*/

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  String _pageTitle = 'Home';

  static const List<Widget> _widgetOptions = <Widget>[
    Feeds(),
    DiscoverPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Discover',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

