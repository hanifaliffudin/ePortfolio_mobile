import 'package:eportfolio/widgets/card/article_feed.dart';
import 'package:flutter/material.dart';

class ArticlesContent extends StatefulWidget {
  const ArticlesContent({Key? key}) : super(key: key);

  @override
  State<ArticlesContent> createState() => _ArticlesContentState();
}

class _ArticlesContentState extends State<ArticlesContent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ArticleFeed(),
      ],
    );
  }
}
