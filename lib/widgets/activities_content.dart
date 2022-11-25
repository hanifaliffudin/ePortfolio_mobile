import 'package:eportfolio/widgets/box_add_post.dart';
import 'package:flutter/material.dart';
import 'card/post_feed.dart';
import 'card/article_feed.dart';

class Activities extends StatefulWidget {
  const Activities({Key? key}) : super(key: key);

  @override
  State<Activities> createState() => _ActivitiesState();
}

class _ActivitiesState extends State<Activities> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 7,),
        BoxAddPost(),
        PostFeed(),
       ],
    );
  }
}
