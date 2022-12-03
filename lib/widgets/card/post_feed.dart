import 'dart:convert';

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

  void postTimeline() async{
    await http
        .get(Uri.parse('http://10.0.2.2:8800/api/posts/timeline/all'))
        .then((value) {
          var data = json.decode(value.body);
          for (int i =0 ; i < data.length; i++) {
            print('indexs=${data[i]}');
            //postList.add(PostModel(data[i]['userId'].toString(), data[i]['desc'].toString(), data[i]['createdAt'.toString()]));
          }
          setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
       return Column(
              children : [
                    Card(
                      child: InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>PostCardOpen()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              HeaderFeedCard(),
                              const SizedBox(height: 10,),
                              /*Container(
                                margin: EdgeInsets.all(10),
                                child: Text(
                                    'text dummy',
                                    //postList[index].desc,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis),
                              ),*/
                              const Text
                                ('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,),
                              const SizedBox(height: 10,),
                              const Image(image: NetworkImage('https://ceblog.s3.amazonaws.com/wp-content/uploads/2018/08/20142340/best-homepage-9.png'))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
  }
}
