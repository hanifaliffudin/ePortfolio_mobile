import 'package:eportfolio/widgets/box_add_post.dart';
import 'package:eportfolio/widgets/feed/project_feed.dart';
import 'package:flutter/material.dart';
import 'package:eportfolio/widgets/feed/post_feed.dart';

class Feeds extends StatefulWidget {
  const Feeds({Key? key}) : super(key: key);

  @override
  State<Feeds> createState() => _FeedsState();
}

class _FeedsState extends State<Feeds> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          BoxAddPost(),
          Column(
            children: [
              PostFeed(),
              ProjectFeed()
            ],
          ),
        ],
      ),
    );
  }
}
