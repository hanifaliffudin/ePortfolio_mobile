import 'dart:convert';

import 'package:eportfolio/widgets/box_add_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../config.dart';
import '../models/post_model.dart';
import 'card/header_feed_card.dart';
import 'package:http/http.dart' as http;
class Activities extends StatefulWidget {
  const Activities({Key? key}) : super(key: key);

  @override
  State<Activities> createState() => _ActivitiesState();
}

class _ActivitiesState extends State<Activities> {

  List<PostModel> postList =[];
  final storage = FlutterSecureStorage();

  void userActivities() async{

    var url = Config.userActivities;
    var userId = await storage.read(key: 'userId');
    await http
        .get(Uri.parse('$url/$userId'))
        .then((value) {
      var data = jsonDecode(value.body);
      for (int i =0 ; i < data.length; i++) {
        print('index=${data[i]}');
        postList.add(PostModel(data[i]['userId'].toString(), data[i]['desc'].toString(), data[i]['updatedAt'.toString()]));
      }
      setState(() {});
    });
  }

  @override
  void initState(){
    super.initState();
    userActivities();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 7,),
        BoxAddPost(),
        ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount:postList.length,
            shrinkWrap: true,
            itemBuilder :(context, index){
              return Card(
                child: Container(
                  margin: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      HeaderFeedCard(postData: postList[index]),
                      const SizedBox(height: 10,),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          margin: EdgeInsets.all(10),
                          child: new Text(
                            postList[index].desc,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Image(image: NetworkImage('https://ceblog.s3.amazonaws.com/wp-content/uploads/2018/08/20142340/best-homepage-9.png')),
                      ),
                      const SizedBox(height: 10,),
                      Align(
                        alignment: Alignment.topLeft,
                        child: new Text(
                            postList[index].updatedAt
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
        )
       ],
    );
  }
}
