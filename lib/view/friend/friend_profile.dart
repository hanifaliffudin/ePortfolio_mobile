import 'package:eportfolio/widgets/custom_appBar.dart';
import 'package:flutter/material.dart';
import '../album.dart';
import 'friend_about_me_tab.dart';
import 'friend_activity_tab.dart';
import 'friend_album_tab.dart';
import 'friend_posts_content.dart';
import 'friend_article_content.dart';
import 'friend_badge_tab.dart';
import 'friend_profile_header.dart';
import 'friend_project_tab.dart';

class FriendProfilePage extends StatefulWidget {
  FriendProfilePage(this.selectedIndex, {Key? key}) : super(key: key);
  int selectedIndex;
  static const routeName = '/friendprofile';

  @override
  State<FriendProfilePage> createState() => _FriendProfilePageState(selectedIndex!);
}

class _FriendProfilePageState extends State<FriendProfilePage> {
  int selectedIndex;
  _FriendProfilePageState(this.selectedIndex);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: CustomAppBar(),
      body: DefaultTabController(
        initialIndex: selectedIndex!,
        length: 7,
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
                const Material(
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
                      Tab(
                        child: Text(
                          'Projects',
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
                        FriendPosts(userId: args.toString()),
                      ],
                    ),
                    ListView(
                      children: [
                        FriendArticlesContent(userId: args.toString())
                      ],
                    ),
                    ListView(
                      children: [
                        FriendActivityTab(userId: args.toString()),
                      ],
                    ),
                    ListView(
                      children: [FriendBadges(userId: args.toString())],
                    ),
                    ListView(
                      children: [FriendAlbum(userId: args.toString())],
                    ),
                    ListView(
                      children: [FriendProjectsTab(userId: args.toString())],
                    ),
                  ],
                ))
              ],
            )),
      ),
    );
  }
}
