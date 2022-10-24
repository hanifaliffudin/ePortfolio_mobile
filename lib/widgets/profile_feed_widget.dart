import 'package:flutter/material.dart';
import 'package:eportfolio/widgets/feed_card.dart';

class ProfileFeed extends StatefulWidget {
  const ProfileFeed({Key? key}) : super(key: key);

  @override
  State<ProfileFeed> createState() => _ProfileFeedState();
}

class _ProfileFeedState extends State<ProfileFeed> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          decoration: new BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Color(0xFFF6F6F6),
          ),
          child: Column(
            children: [
              TextField(
                keyboardType: TextInputType.multiline,
                maxLines: 2,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'What is going on?',
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: (){},
                          icon: Icon(Icons.image)
                      ),
                      IconButton(
                          onPressed: (){},
                          icon: Icon(Icons.video_file)
                      ),
                    ],
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.blue
                    ),
                    onPressed: (){},
                    child: Text(
                      'Post',
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        FeedCard()
      ],
    );
  }
}
