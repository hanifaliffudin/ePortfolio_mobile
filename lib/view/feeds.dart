import 'package:flutter/material.dart';
import 'package:eportfolio/widgets/feed_card.dart';

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
        children: List.generate(7, (index) {
          return FeedCard();
        }),
      ),
    );
  }
}
