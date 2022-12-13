import 'dart:convert';

import 'package:eportfolio/config.dart';
import 'package:eportfolio/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../models/users_model.dart';

class ProfileHeader extends StatefulWidget {

  ProfileHeader({Key? key}) : super(key: key);

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}


class _ProfileHeaderState extends State<ProfileHeader> {

  String? username;
  String? major;
  String? nim;
  String? city;

  final storage = FlutterSecureStorage();

  void getUser() async{
    var userId = await storage.read(key: 'userId');
    var url = Config.users;
    await http
        .get(Uri.parse('$url/$userId'))
        .then((value) {
      var data = jsonDecode(value.body);
      username = data['username'];
      nim = data['nim'];
      major = data['major'];
      city = data['city'];
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
      padding: EdgeInsets.only(left: 20, top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        ('https://ceblog.s3.amazonaws.com/wp-content/uploads/2018/08/20142340/best-homepage-9.png')),
                    radius: 60,
                  ),
                  //SizedBox(height: 10,),
                ],
              ),
              SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(username ?? '',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 5,
                  ),
                  Text(nim ?? '',
                      style: TextStyle(fontWeight: FontWeight.w600)),
                  SizedBox(
                    height: 5,
                  ),
                  Text(major ?? ''),
                  SizedBox(
                    height: 5,
                  ),
                  Text(city ?? ''),
                ],
              )
            ],
          ),
          SizedBox(
            height: 130,
          ),
          IconButton(onPressed: () {
            settingButton(context);
          }, icon: Icon(Icons.more_horiz)),
        ],
      ),
    );
  }
}

void settingButton(context){
  showModalBottomSheet(context: context, builder: (context)=>
      Container(
        height: 50,
        margin: EdgeInsets.only(left: 10, top: 10,right: 10),
        child: Column(
          children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                ),
                onPressed: () {

                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Edit'),
                    Icon(Icons.edit)
                  ],
                )
            ),
          ],
        ),
      ));
}
