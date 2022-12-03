import 'dart:convert';

import 'package:eportfolio/widgets/box_add_post.dart';
import 'package:eportfolio/widgets/card/article_feed.dart';
import 'package:flutter/material.dart';
import 'package:eportfolio/widgets/card/post_feed.dart';
import 'package:http/http.dart' as http;
import '../models/post_model.dart';
import '../widgets/card/header_feed_card.dart';

class Feeds extends StatefulWidget {
  const Feeds({Key? key}) : super(key: key);

  @override
  State<Feeds> createState() => _FeedsState();
}

class _FeedsState extends State<Feeds> {

  List<PostModel> postList =[];
  void postTimeline() async{
    await http
        .get(Uri.parse('http://10.0.2.2:8800/api/posts/timeline/all'))
        .then((value) {
      var data = json.decode(value.body);
      for (int i =0 ; i < data.length; i++) {
        print('index=${data[i]}');
        postList.add(PostModel(/*data[i]['userId'].toString(),*/ data[i]['desc'].toString()/*, data[i]['createdAt'.toString()]*/));
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
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(
        children: <Widget> [
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
                        HeaderFeedCard(),
                        const SizedBox(height: 10,),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            margin: EdgeInsets.all(10),
                            child: new Text(
                              //'Hi',
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
                        )
                      ],
                    ),
                  ),
                );
            }
          )
        ],
      ),
    );
  }
}
