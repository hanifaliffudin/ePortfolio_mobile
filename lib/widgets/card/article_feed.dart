import 'package:eportfolio/widgets/card/header_feed_card.dart';
import 'package:eportfolio/widgets/open_feed/article_card_open.dart';
import 'package:flutter/material.dart';

class ArticleFeed extends StatefulWidget {
  const ArticleFeed({Key? key}) : super(key: key);

  @override
  State<ArticleFeed> createState() => _ArticleFeedState();
}

class _ArticleFeedState extends State<ArticleFeed> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          child: Card(
            child: InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ProjectCardOpen()));
              },
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    // HeaderFeedCard(postData: 'tes'),
                    const SizedBox(height: 10,),
                    const Text
                      ('This is artikel '
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ',maxLines: 2,overflow: TextOverflow.ellipsis,),
                    const SizedBox(height: 10,),
                    const Image(image: NetworkImage('https://ceblog.s3.amazonaws.com/wp-content/uploads/2018/08/20142340/best-homepage-9.png')),
                    const SizedBox(height: 10,),
                    Align(
                      alignment: Alignment.topLeft,
                      child: const Text('13 Ways to Lorem ipsum dolor sit amet.', //JUDUL
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
