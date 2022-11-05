import 'package:flutter/material.dart';

class PostCardOpen extends StatefulWidget{
  @override
  State<PostCardOpen> createState()=> _FeedCardOpen();
}

class _FeedCardOpen extends State<PostCardOpen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: (){},
              icon: Icon(Icons.logout)
          )

        ],
        centerTitle: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('FILKOM'),
            Text(
              'Student Dashboard',
              style: TextStyle(
                  fontSize: 16
              ),
            ),
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        child : Card(
          child: Padding(
            padding: EdgeInsets.all(10),
            child : Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          child : Icon(Icons.person),
                          radius: 25,
                        ),
                        const SizedBox(width: 8,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Nafira Ramadhannis',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18
                              ),
                            ),
                            Text(
                              '1751502021111007'
                            ),
                            Text('11.20 PM・22 Oct 2022')
                          ],
                        )
                      ],
                    ),
                    IconButton(
                      onPressed: (){},
                      icon: Icon(Icons.more_horiz),
                    )
                  ],
                ),
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