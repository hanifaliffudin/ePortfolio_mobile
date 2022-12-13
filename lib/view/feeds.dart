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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(
        children: <Widget> [
          BoxAddPost(),
          PostFeed()
        ],
      ),
    );
  }
}
