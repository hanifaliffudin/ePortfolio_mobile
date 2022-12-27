import 'dart:convert';

import 'package:eportfolio/config.dart';
import 'package:eportfolio/services/api_service.dart';
import 'package:eportfolio/widgets/update_page/user_profile_edit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../models/user_model.dart';
import '../models/users_response_model.dart';


class ProfileHeader extends StatefulWidget {
  ProfileHeader({Key? key}) : super(key: key);

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {

  var data;
  String? username;
  String? major;
  String? nim;
  String? profilePicture;
  String? city;

  Future<Map<String, dynamic>> getUserData() async{
    data = await APIService.getUserData();
    username = data['username'];
    major = data['major'];
    nim = data['nim'];
    profilePicture = data['profilePicture'];
    city = data['city'];
    return data;
  }

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getUserData(),
        builder: (context, snapshot){
          if(snapshot.hasData){
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
                          Container(
                            width: 120,
                            alignment: Alignment.center,
                            margin: EdgeInsets.all(10),
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                (profilePicture ==
                                    null ||
                                    profilePicture ==
                                        "")
                                    ? "https://ceblog.s3.amazonaws.com/wp-content/uploads/2018/08/20142340/best-homepage-9.png"
                                    : '${Config.apiURL}/${profilePicture.toString()}',
                              ), radius: 60,
                            )
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
                                    Navigator.of(context).popAndPushNamed('/editUser'/*, arguments: [
                                      snapshot.data!.nim,
                                      snapshot.data!.major,
                                      snapshot.data!.city,
                                      snapshot.data!.dateBirth,
                                      snapshot.data!.gender,
                                      snapshot.data!.interest,
                                      snapshot.data!.about,
                                      snapshot.data!.socialMedia,
                                      snapshot.data!.skill,
                                      snapshot.data!.profilePicture
                                    ]*/);
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
                  }, icon: Icon(Icons.more_horiz)),
                ],
              ),
            );
          } else {
            return CircularProgressIndicator();
          }
        }
    );
  }
}