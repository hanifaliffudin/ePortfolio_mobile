import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:snippet_coder_utils/FormHelper.dart';

import '../../config.dart';
import '../../models/post_model.dart';
import '../../services/api_service.dart';
import '../../view/home.dart';

class HeaderFeedCard extends StatefulWidget {
  HeaderFeedCard({required this.postData});
  PostModel postData;

  @override
  State<HeaderFeedCard> createState() => _HeaderFeedCardState(postData);
}

class _HeaderFeedCardState extends State<HeaderFeedCard> {

  String? username;
  String? major;
  String? date;
  String? jwt;
  PostModel postData;
  var ntap;
  var postId;
  var userId;

  _HeaderFeedCardState(this.postData);

  Future<Map<String, dynamic>> getIdUserPosting() async {
    final storage = FlutterSecureStorage();
    userId = await storage.read(key: 'userId');
    ntap = await APIService.getIdUserPosting(postData.userId);
    username = ntap['username'];
    major = ntap['major'];
    date = ntap['date'];
    return ntap;
  }

  Future<bool> deletePost() async {
    postId = await APIService.deletePost(postData.id);
    return postId;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getIdUserPosting(),
      builder: (context, snapshot){
        if (snapshot.hasData){
          return Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      backgroundImage: NetworkImage(('https://picsum.photos/200')),
                      radius: 25,
                    ),
                    const SizedBox(width: 8,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          username ?? '',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18
                          ),
                        ),
                        Text(major ?? ''),
                        /*Text(postList[index].updatedAt)*/
                      ],
                    ),
                  ],
                ),
                Container(
                    child: userId != postData.userId
                        ? Container()
                        : IconButton(
                        onPressed: () {
                          settingButton(context);
                        },
                        icon: Icon(Icons.more_horiz)))
              ],
            ),
          );
        } else
          return CircularProgressIndicator();
      }
    );
  }
  void settingButton(context) {
    showModalBottomSheet(
        context: context,
        builder: (context) => Container(
          height: 100,
          margin: EdgeInsets.only(left: 10, top: 10, right: 10),
          child: Column(
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(),
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('Edit'), Icon(Icons.edit)],
                  )),
              FutureBuilder(
                future: deletePost(),
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    return ElevatedButton(
                        style: ElevatedButton.styleFrom(),
                        onPressed: () {
                          deletePost().then((response){
                            FormHelper.showSimpleAlertDialog(
                              context,
                              "Success!",
                              "Success delete post!",
                              "OK",
                                  () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HomePage(jwt ?? '')));
                              },
                            );
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Text('Delete'), Icon(Icons.remove)],
                        ));
                  }else {
                    return CircularProgressIndicator();
                  }
                }
              ),
            ],
          ),
        ));
  }
}


