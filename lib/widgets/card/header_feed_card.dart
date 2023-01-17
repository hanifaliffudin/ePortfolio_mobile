import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:custom_switch/custom_switch.dart';

import '../../config.dart';
import '../../models/post_model.dart';
import '../../services/api_service.dart';

class HeaderFeedCard extends StatefulWidget {
  HeaderFeedCard({required this.postData});

  PostModel postData;

  @override
  State<HeaderFeedCard> createState() => _HeaderFeedCardState(postData);
}

class _HeaderFeedCardState extends State<HeaderFeedCard> {
  String? username;
  String? profilePicture;
  String? major;
  String? organization;
  PostModel postData;
  var data;
  var postId;
  var userId;

  _HeaderFeedCardState(this.postData);

  Future<Map<String, dynamic>> getIdUser() async {
    final storage = FlutterSecureStorage();
    userId = await storage.read(key: 'userId');
    data = await APIService.getIdUser(postData.userId);
    username = data['username'];
    profilePicture = data['profilePicture'];
    major = data['major'];
    organization = data['organization'];
    return data;
  }

  Future<bool> deletePost() async {
    postId = await APIService.deletePost(postData.id);
    return postId;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getIdUser(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      userId == postData.userId
                          ? GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/profile');
                              },
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(
                                  (profilePicture == null ||
                                          profilePicture == "")
                                      ? "https://ceblog.s3.amazonaws.com/wp-content/uploads/2018/08/20142340/best-homepage-9.png"
                                      : '${Config.apiURL}/${profilePicture.toString()}',
                                ),
                                radius: 25,
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/friendprofile',
                                    arguments: postData.userId);
                              },
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(
                                  (profilePicture == null ||
                                          profilePicture == "")
                                      ? "https://ceblog.s3.amazonaws.com/wp-content/uploads/2018/08/20142340/best-homepage-9.png"
                                      : '${Config.apiURL}/${profilePicture.toString()}',
                                ),
                                radius: 25,
                              ),
                            ),
                      const SizedBox(
                        width: 8,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            username ?? '',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Text('${major ?? ''} | ${organization ?? ''}', overflow: TextOverflow.ellipsis,),
                          Text(DateFormat.yMMMEd().format(DateTime.parse(postData.updatedAt)))
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
        });
  }

  void settingButton(context) {
    bool status = false;
    String value;

    showModalBottomSheet(
        context: context,
        builder: (context) => Container(
              height: 150,
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
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(),
                      onPressed: () {
                        deletePost().then((response) {
                          FormHelper.showSimpleAlertDialog(
                            context,
                            "Success!",
                            "Success delete post!",
                            "OK",
                            () {
                              Navigator.pushNamed(context, '/home');
                            },
                          );
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text('Delete'), Icon(Icons.remove)],
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Visibility'),
                      CustomSwitch(
                        activeColor: Colors.pinkAccent,
                        value: status,
                        onChanged: (value) {
                          if (value == true) {
                            print("Public");
                          } else {
                            print("Private");
                          }
                          setState(() {
                            status = value;
                          });
                        },
                      ),
                    ],
                  )
                ],
              ),
            ));
  }
}
