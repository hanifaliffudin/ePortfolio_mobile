import 'package:custom_switch/custom_switch.dart';
import 'package:eportfolio/models/article_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../config.dart';
import '../../services/api_service.dart';
class HeaderArticle extends StatefulWidget {

  HeaderArticle({required this.articleData});
  ArticleModel articleData;

  @override
  State<HeaderArticle> createState() => _HeaderArticleState(articleData);
}

class _HeaderArticleState extends State<HeaderArticle> {

  _HeaderArticleState(ArticleModel this.articleData);

  ArticleModel articleData;
  String? username;
  String? profilePicture;
  String? major;
  var data;
  var postId;
  var userId;

  Future<Map<String, dynamic>> getIdUser() async {
    final storage = FlutterSecureStorage();
    userId = await storage.read(key: 'userId');
    data = await APIService.getIdUser(articleData.userId);
    username = data['username'];
    profilePicture = data['profilePicture'];
    major = data['major'];
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getIdUser(),
      builder: (context, snapshot){
        if(snapshot.hasData){
          return Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                        (profilePicture ==
                            null ||
                            profilePicture ==
                                "")
                            ? "https://ceblog.s3.amazonaws.com/wp-content/uploads/2018/08/20142340/best-homepage-9.png"
                            : '${Config.apiURL}/${profilePicture.toString()}',
                      ), radius: 25,
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
                    child: userId != articleData.userId
                        ? Container()
                        : IconButton(
                        onPressed: () {
                          settingButton(context);
                        },
                        icon: Icon(Icons.more_horiz)))
              ],
            ),
          );
        } else return CircularProgressIndicator();
      }
    );
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
                  onPressed: () {},
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
                      if(value == true){
                        print("Public");
                      } else{
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
