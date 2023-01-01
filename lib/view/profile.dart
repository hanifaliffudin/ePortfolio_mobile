import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:eportfolio/widgets/profile_header_widget.dart';
import 'package:eportfolio/widgets/about_me_content.dart';
import 'package:eportfolio/widgets/collections_content.dart';
import '../achivement_content.dart';
import '../article_content.dart';
import '../widgets/activities_content.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  static const routeName = '/profile';

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      
      length: 5,
      child: NestedScrollView(
          headerSliverBuilder: (context, _){
            return [
              SliverList(
                  delegate: SliverChildListDelegate(
                      [
                        ProfileHeader()
                      ]
                  )
              )
            ];
          },
          body: Column(
            children: [
              Material(
                child: TabBar(
                  isScrollable: true,
                  tabs: [
                    Tab(
                      child: Text(
                          'About Me',
                          style: TextStyle(
                              color: Colors.black
                          )
                      ),
                    ),
                    Tab(
                      child: Text(
                          'Posts',
                          style: TextStyle(
                              color: Colors.black
                          )
                      ),
                    ),
                    Tab(
                      child: Text(
                          'Articles',
                          style: TextStyle(
                              color: Colors.black
                          )
                      ),
                    ),
                    Tab(
                      child: Text(
                          'Activities',
                          style: TextStyle(
                              color: Colors.black
                          )
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Badges',
                        style: TextStyle(
                          color: Colors.black
                        ),
                      ),
                    )
                  ],
                ),

              ),
              Expanded(
                  child: TabBarView(
                      children: [
                        ListView(
                          children: [
                            AboutMeContent(),
                          ],
                        ),
                        ListView(
                          children: [
                            Activities(),
                          ],
                        ),
                        ListView(
                          children: [
                            ArticlesContent()
                          ],
                        ),
                        ListView(
                          children: [
                            CollectionContent(),
                          ],
                        ),
                        ListView(
                          children: [
                            Achivement()
                          ],
                        ),
                      ],
                  )
              )
            ],
          )
      ),
    );
  }
}
