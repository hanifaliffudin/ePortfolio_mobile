import 'package:eportfolio/widgets/card/header_feed_card.dart';
import 'package:flutter/material.dart';
import '../custom_appBar.dart';

class PostCardOpen extends StatefulWidget{
  @override
  State<PostCardOpen> createState()=> _FeedCardOpen();
}

class _FeedCardOpen extends State<PostCardOpen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Container(
        padding: const EdgeInsets.all(8),
        child : Card(
          child: Padding(
            padding: EdgeInsets.all(10),
            child : Column(
              children: [
                // HeaderFeedCard(biodata: 'tes'),
                const SizedBox(
                  height: 10,
                ),
                const Text
                  ('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur id ultrices metus. Vestibulum varius eros at urna convallis porttitor. Curabitur eros lacus, pulvinar vel orci in, mollis feugiat augue. Ut risus quam, lacinia in faucibus sit amet, pretium a eros. Suspendisse nec bibendum sem. Aenean non tincidunt orci. Nunc sodales justo ac convallis ullamcorper. Nulla sollicitudin, ex vitae consectetur elementum, velit purus mollis quam, non efficitur felis lectus vitae justo. Aliquam aliquam tortor quis lorem pulvinar suscipit.',),
                const SizedBox(height: 10,),
                const Image(image: NetworkImage('https://ceblog.s3.amazonaws.com/wp-content/uploads/2018/08/20142340/best-homepage-9.png'))
              ],
            )
          )
        )
      ),
    );
  }
}