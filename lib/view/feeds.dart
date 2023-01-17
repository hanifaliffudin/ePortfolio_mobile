import 'package:eportfolio/widgets/box_add_post.dart';
import 'package:eportfolio/widgets/card/article_feed.dart';
import 'package:flutter/material.dart';
import 'package:eportfolio/widgets/card/post_feed.dart';

class Feeds extends StatefulWidget {
  const Feeds({Key? key}) : super(key: key);

  @override
  State<Feeds> createState() => _FeedsState();
}
class _FeedsState extends State<Feeds> {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(
        children: <Widget> [
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 150),
                child: Text('Selamat Datang \nNafira', style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18
                ),),
              ),
              CircleAvatar(
                radius: 25,
                child: Icon(Icons.supervised_user_circle),
              )
            ],
          ),
          SizedBox(height: 5,),
          BoxAddPost(),
          ArticleFeed(),
          PostFeed(),
        ],
      ),
    );
  }
}
