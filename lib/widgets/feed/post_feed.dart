import 'package:eportfolio/widgets/open_feed/post_card_open.dart';
import 'package:flutter/material.dart';

class PostFeed extends StatefulWidget {
  const PostFeed({Key? key}) : super(key: key);

  @override
  State<PostFeed> createState() => _PostFeedState();
}

class _PostFeedState extends State<PostFeed> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Card(
        child: InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>PostCardOpen()));
          },
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          child: Icon(Icons.person),
                          radius: 25,
                        ),
                        const SizedBox(width: 8,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Hanif Aliffudin',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18
                              ),
                            ),
                            Text('Teknik Informatika'),
                            Text('01.28 PM ・ 2 Aug 2022')
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                        onPressed: (){},
                        icon: Icon(Icons.more_horiz)
                    )
                  ],
                ),
                const SizedBox(height: 10,),
                const Text
                  ('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ',maxLines: 2,overflow: TextOverflow.ellipsis,),
                const SizedBox(height: 10,),
                const Image(image: NetworkImage('https://ceblog.s3.amazonaws.com/wp-content/uploads/2018/08/20142340/best-homepage-9.png'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
