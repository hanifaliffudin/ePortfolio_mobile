import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../../config.dart';

class AboutMe extends StatefulWidget {
  const AboutMe({Key? key}) : super(key: key);

  @override
  State<AboutMe> createState() => _AboutMeState();
}

class _AboutMeState extends State<AboutMe> {
  final storage = FlutterSecureStorage();
  String? about;

  void getUser() async{
    var url = Config.users;
    var userId = await storage.read(key: 'userId');
    await http
        .get(Uri.parse('$url/$userId'))
        .then((value) {
      var data = jsonDecode(value.body);
      about = data['about'];
      setState(() {});
    });
  }

  @override
  void initState(){
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Card(
        color: Colors.grey[200],
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'About Me',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ],
                      ),
                    ],
                  ),
                  IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz))
                ],
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Align(
                      child: Container(
                          padding:
                          EdgeInsets.only(right: 12, left: 10, top: 10, bottom: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            //crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  about ?? '',
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          )
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
