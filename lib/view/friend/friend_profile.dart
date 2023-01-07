import 'package:eportfolio/widgets/custom_appBar.dart';
import 'package:flutter/material.dart';
import 'package:eportfolio/widgets/activity_tab.dart';

import '../../badges_tab.dart';
import '../album.dart';
import 'friend_about_me_tab.dart';
import 'friend_activities_content.dart';
import 'friend_article_content.dart';
import 'friend_profile_header.dart';

class FriendProfilePage extends StatefulWidget {
  const FriendProfilePage({Key? key}) : super(key: key);

  static const routeName = '/friendprofile';

  @override
  State<FriendProfilePage> createState() => _FriendProfilePageState();
}

class _FriendProfilePageState extends State<FriendProfilePage> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: CustomAppBar(),
      body: DefaultTabController(
        length: 6,
        child: NestedScrollView(
            headerSliverBuilder: (context, _) {
              return [
                SliverList(
                    delegate: SliverChildListDelegate(
                        [FriendProfileHeader(userId: args.toString())]))
              ];
            },
            body: Column(
              children: [
                Material(
                  child: TabBar(
                    isScrollable: true,
                    tabs: [
                      Tab(
                        child: Text('About Me',
                            style: TextStyle(color: Colors.black)),
                      ),
                      Tab(
                        child: Text('Posts',
                            style: TextStyle(color: Colors.black)),
                      ),
                      Tab(
                        child: Text('Articles',
                            style: TextStyle(color: Colors.black)),
                      ),
                      Tab(
                        child: Text('Activities',
                            style: TextStyle(color: Colors.black)),
                      ),
                      Tab(
                        child: Text(
                          'Badges',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Album',
                          style: TextStyle(color: Colors.black),
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
                        FriendAboutMeContent(userId: args.toString()),
                      ],
                    ),
                    ListView(
                      children: [
                        FriendActivities(userId: args.toString()),
                      ],
                    ),
                    ListView(
                      children: [
                        FriendArticlesContent(userId: args.toString())
                      ],
                    ),
                    ListView(
                      children: [
                        ActivityTab(),
                      ],
                    ),
                    ListView(
                      children: [Badges()],
                    ),
                    ListView(
                      children: [Album()],
                    ),
                  ],
                ))
              ],
            )),
      ),
    );
  }
}
