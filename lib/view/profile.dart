import 'package:eportfolio/widgets/custom_appBar.dart';
import 'package:flutter/material.dart';
import 'package:eportfolio/widgets/profile_header_widget.dart';
import 'package:eportfolio/widgets/about_me_content.dart';
import 'package:eportfolio/widgets/activity_tab.dart';
import '../badges_tab.dart';
import '../article_tab.dart';
import '../widgets/post_tab.dart';
import 'album.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage(this.selectedIndex, {Key? key}) : super(key: key);
  final int? selectedIndex;

  static const routeName = '/profile';

  @override
  State<ProfilePage> createState() => _ProfilePageState(selectedIndex!);
}

class _ProfilePageState extends State<ProfilePage> {
  int? selectedIndex;
  _ProfilePageState(this.selectedIndex);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: CustomAppBar(),
      body: DefaultTabController(
        initialIndex: selectedIndex!,
        length: 6,
        child: NestedScrollView(
            headerSliverBuilder: (context, _) {
              return [
                SliverList(
                    delegate: SliverChildListDelegate(
                        [ProfileHeader()]
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
                        PostTab(),
                      ],
                    ),
                    ListView(
                      children: [ArticleTab()],
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
                      children: [
                        Album()
                      ],
                    ),
                  ],
                ))
              ],
            )),
      ),
    );
  }
}
