import 'package:eportfolio/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  
  CustomAppBar({Key? key,}) : super(key: key);
  final storage = FlutterSecureStorage();


  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: <Widget>[
        Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/profile');
              },
              child: Icon(
                Icons.home,
                size: 33.0,
              ),
            )
        ),
        IconButton(
            onPressed: (){
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
              storage.delete(key: 'jwt');
              storage.delete(key: 'userId');
            },
            icon: Icon(Icons.logout)
        )
      ],
      centerTitle: false,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('E-PORTFOLIO'),
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(60.0);
}
