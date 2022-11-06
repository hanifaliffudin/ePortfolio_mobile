import 'package:flutter/material.dart';
import 'package:eportfolio/widgets/profile_header_widget.dart';
import 'package:eportfolio/widgets/about_me_content.dart';
import 'package:eportfolio/widgets/achivement_content.dart';
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
      length: 3,
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
                          'Activities',
                          style: TextStyle(
                              color: Colors.black
                          )
                      ),
                    ),
                    Tab(
                      child: Text(
                          'Achivements',
                          style: TextStyle(
                              color: Colors.black
                          )
                      ),
                    ),
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
                            Activities()
                            //ArticlesFeed()
                          ],
                        ),
                        ListView(
                          children: [
                            AchivementContent(),
                          ],
                        ),
                      ]
                  )
              )
            ],
          )
      ),
    );
  }
}
