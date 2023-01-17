import 'package:eportfolio/view/discover.dart';
import 'package:eportfolio/view/profile.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_appBar.dart';
import 'feeds.dart';

class HomePage extends StatefulWidget {
  const HomePage(this._selectedIndex, {Key? key}) : super(key: key);

  final int _selectedIndex;

  @override
  State<HomePage> createState() => _HomePageState(_selectedIndex);
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex;

  static const List<Widget> _widgetOptions = <Widget>[
    Feeds(),
    DiscoverPage(),
    ProfilePage(),
  ];

  _HomePageState(this._selectedIndex);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
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

