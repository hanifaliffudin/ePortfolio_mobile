import 'package:eportfolio/view/contributors.dart';
import 'package:eportfolio/widgets/card/header_feed_card.dart';
import 'package:flutter/material.dart';

import '../custom_appBar.dart';

class ProjectCardOpen extends StatefulWidget {
  const ProjectCardOpen({Key? key}) : super(key: key);

  @override
  State<ProjectCardOpen> createState() => _ProjectCardOpenState();
}

class _ProjectCardOpenState extends State<ProjectCardOpen> {
  get raisedButtonStyle => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Container(
          padding: const EdgeInsets.all(8),
          child: Card(
              child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      HeaderFeedCard(),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('13 Ways to Lorem ipsum dolor sit amet.', //JUDUL
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      const Image( //COVER IMAGE
                          image: NetworkImage(
                              'https://ceblog.s3.amazonaws.com/wp-content/uploads/2018/08/20142340/best-homepage-9.png')),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur id ultrices metus. Vestibulum varius eros at urna convallis porttitor. Curabitur eros lacus, pulvinar vel orci in, mollis feugiat augue. Ut risus quam, lacinia in faucibus sit amet, pretium a eros. Suspendisse nec bibendum sem. Aenean non tincidunt orci. Nunc sodales justo ac convallis ullamcorper. Nulla sollicitudin, ex vitae consectetur elementum, velit purus mollis quam, non efficitur felis lectus vitae justo. Aliquam aliquam tortor quis lorem pulvinar suscipit.',
                      ),
                    ],
                  )))),
    );
  }
}
