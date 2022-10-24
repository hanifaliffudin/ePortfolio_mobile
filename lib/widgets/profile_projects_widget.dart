import 'package:eportfolio/widgets/project_card_open.dart';
import 'package:flutter/material.dart';
import 'package:eportfolio/view/add_project.dart';

import 'feed_card_open.dart';

class ProfileProjects extends StatefulWidget {
  const ProfileProjects({Key? key}) : super(key: key);

  @override
  State<ProfileProjects> createState() => _ProfileProjectsState();
}

class _ProfileProjectsState extends State<ProfileProjects> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.blue,
              minimumSize: const Size.fromHeight(50), // NEW
            ),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => const AddProject())
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Add new project',
                  style: TextStyle(fontSize: 20),
                ),
                Icon(Icons.add)
              ],
            ),
          ),
        ),
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
                              child: Icon(Icons.person),
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
