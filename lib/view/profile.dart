import 'package:flutter/material.dart';
import 'package:eportfolio/widgets/profile_header_widget.dart';
import 'package:eportfolio/widgets/profile_feed_widget.dart';
import 'package:eportfolio/widgets/profile_projects_widget.dart';
import 'package:eportfolio/widgets/profile_certifications_widget.dart';

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
                          'Feed',
                          style: TextStyle(
                              color: Colors.black
                          )
                      ),
                    ),
                    Tab(
                      child: Text(
                          'Projects',
                          style: TextStyle(
                              color: Colors.black
                          )
                      ),
                    ),
                    Tab(
                      child: Text(
                          'Certifications',
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
                            ProfileFeed(),
                          ],
                        ),
                        ListView(
                          children: [
                            ProfileProjects(),
                          ],
                        ),
                        ListView(
                          children: [
                            ProfileCertifications(),
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
