import 'dart:convert';

import 'package:eportfolio/config.dart';
import 'package:eportfolio/login.dart';
import 'package:eportfolio/widgets/open_feed/post_card_open.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../models/post_model.dart';
import 'header_feed_card.dart';

class PostFeed extends StatefulWidget {
  const PostFeed({Key? key}) : super(key: key);

  @override
  State<PostFeed> createState() => _PostFeedState();
}

class _PostFeedState extends State<PostFeed> {

  List<PostModel> postList =[];

  Future<void> postTimeline() async{
    await http
        .get(Uri.parse(Config.timelineApi))
        .then((value) {
      var data = jsonDecode(value.body);
      for (int i =0 ; i < data.length; i++) {
        print('index=${data[i]}');
        postList.add(PostModel(data[i]['userId'].toString(), data[i]['desc'].toString(), data[i]['updatedAt'.toString()], data[i]['_id'.toString()]));
      }
      setState(() {});
    });
  }


  @override
  void initState(){
    super.initState();
    postTimeline();
  }

  @override
  Widget build(BuildContext context) {
        return ListView.builder(
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
                    child: Text('')
                    //Image(image: NetworkImage('https://ceblog.s3.amazonaws.com/wp-content/uploads/2018/08/20142340/best-homepage-9.png')),
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
    );
  }
}
