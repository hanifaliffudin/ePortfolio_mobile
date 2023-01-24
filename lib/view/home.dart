import 'package:eportfolio/login.dart';
import 'package:eportfolio/view/discover.dart';
import 'package:eportfolio/view/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'feeds.dart';

class HomePage extends StatefulWidget {
  const HomePage(this._selectedIndex ,{Key? key}) : super(key: key);

  final int _selectedIndex;


  @override
  State<HomePage> createState() => _HomePageState(_selectedIndex);
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex;
  _HomePageState(this._selectedIndex);

  final List<Widget> _widgetOptions = <Widget>[
    Feeds(),
    DiscoverPage(),
    ProfilePage(0),
  ];



  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final storage = new FlutterSecureStorage();
  Future<String> get jwtOrEmpty async {
    var jwt = await storage.read(key: "jwt");
    if(jwt == null) return "";
    return jwt;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: jwtOrEmpty,
      builder: (context, snapshot){
        if(!snapshot.hasData) return CircularProgressIndicator();
        if(snapshot.data != "") {
          var str = snapshot.data;
          var jwt = str.toString().split(".");
          if(jwt.length !=3) {
            return Login();
          } else {
            return Scaffold(
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
        } else {
          return Login();
        }
      },
    );
  }
}

