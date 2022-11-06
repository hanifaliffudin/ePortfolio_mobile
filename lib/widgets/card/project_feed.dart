import 'package:eportfolio/widgets/open_feed/project_card_open.dart';
import 'package:flutter/material.dart';

class ProjectFeed extends StatefulWidget {
  const ProjectFeed({Key? key}) : super(key: key);

  @override
  State<ProjectFeed> createState() => _ProjectFeedState();
}

class _ProjectFeedState extends State<ProjectFeed> {
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const CircleAvatar(
                              backgroundImage: NetworkImage(('https://picsum.photos/200')),
                              radius: 25,
                            ),
                            const SizedBox(width: 8,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Weather App',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18
                                  ),
                                ),
                                Text('React JS'),
                                Text('6 Contributors')
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
                    const Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ',
                    maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 10,),
                    const Image(image: NetworkImage('https://ceblog.s3.amazonaws.com/wp-content/uploads/2018/08/20142340/best-homepage-9.png'))
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
