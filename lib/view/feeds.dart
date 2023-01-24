import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../config.dart';
import '../models/article_model.dart';
import '../models/user_model.dart';
import '../services/api_service.dart';
import '../widgets/block/comment_block.dart';
import '../widgets/block/comment_block_article.dart';
import '../widgets/box_add_post.dart';
import '../widgets/card/article_feed.dart';
import '../widgets/card/custom_markdown_body.dart';
import '../widgets/card/header_article_card.dart';
import '../widgets/card/header_feed_card.dart';
import '../widgets/card/post_feed.dart';
import '../widgets/custom_appBar.dart';
import '../widgets/open_feed/article_card_open.dart';

class Feeds extends StatefulWidget {
  const Feeds({Key? key}) : super(key: key);

  @override
  State<Feeds> createState() => _FeedsState();
}

class _FeedsState extends State<Feeds> {
  var userId;
  List<dynamic> posts = [];
  List<dynamic> articles = [];
  List<dynamic> feeds = [];
  var dataPost;
  var dataArticle;
  late Future<UserModel> futureUser;

  Future<List<dynamic>> getAllPost() async {
    dataPost = await APIService().fetchPost();
    if (dataPost.isNotEmpty) {
      for (int i = 0; i < dataPost.length; i++) {
        posts.add(dataPost[i].toJson());
      }
    }
    return dataPost;
  }

  Future<List<dynamic>> getAllArticle() async {
    dataArticle = await APIService().fetchArticle();
    if (dataArticle.isNotEmpty) {
      for (int i = 0; i < dataArticle.length; i++) {
        articles.add(dataArticle[i].toJson());
      }
    }
    return dataArticle;
  }

  allFeeds(List<dynamic> newFeed) async{
    feeds.addAll(newFeed);
    feeds.sort((b,a) => a.createdAt.compareTo(b.createdAt));
  }

  @override
  void initState() {
    super.initState();
    getAllPost().then((value) => allFeeds(value));
    getAllArticle().then((value) => allFeeds(value));
    futureUser = APIService().fetchAnyUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, _) {
            return [
              SliverList(
                  delegate: SliverChildListDelegate([
                FutureBuilder<UserModel>(
                  future: futureUser,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: Text(
                                    'Selamat Datang \n${snapshot.data!.username}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, '/profile');
                                  },
                                  child: CircleAvatar(
                                      radius: 25,
                                      backgroundImage: NetworkImage(
                                        (snapshot.data!.profilePicture ==
                                                    null ||
                                                snapshot.data!.profilePicture ==
                                                    "")
                                            ? "https://ceblog.s3.amazonaws.com/wp-content/uploads/2018/08/20142340/best-homepage-9.png"
                                            : '${Config.apiURL}/${snapshot.data!.profilePicture.toString()}',
                                      )),
                                )
                              ],
                            ),
                          ),
                          BoxAddPost(),
                        ],
                      );
                    } else
                      return CircularProgressIndicator();
                  },
                )
              ]))
            ];
          },
          body: Column(
            children: [
              TabBar(
                tabs: [
                  Tab(
                    child: Text('Feeds', style: TextStyle(color: Colors.black)),
                  ),
                  Tab(
                    child:
                        Text('Projects', style: TextStyle(color: Colors.black)),
                  ),
                ],
              ),
              Expanded(
                  child: TabBarView(
                children: [
                  ListView(
                    children: [
                      FutureBuilder(
                        future: getAllArticle(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: feeds.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        children: [
                                          Container(
                                              child: feeds[index].runtimeType == ArticleModel ?
                                              Visibility(
                                                visible: feeds[index].isPublic,
                                                child: Column(
                                                  children: [
                                                    HeaderArticle(articleData: feeds[index]),
                                                    const SizedBox(height: 10,),
                                                    GestureDetector(
                                                      onTap: (){
                                                        Navigator.push(context , MaterialPageRoute(builder: (context) => ArticleCardOpen(articleData: feeds[index])),
                                                        );
                                                      },
                                                      child: Column(
                                                        children: [
                                                          Align(
                                                            alignment: Alignment.topLeft,
                                                            child: Container(
                                                              margin: EdgeInsets.all(10),
                                                              child: Text(feeds[index].title,style: TextStyle(
                                                                  fontWeight: FontWeight.bold
                                                              ),),
                                                            ),
                                                          ),
                                                          Align(
                                                            alignment: Alignment.topLeft,
                                                            child: Container(
                                                              margin: EdgeInsets.only( left:10, right:10, bottom:5),
                                                              child: CustomMarkdownBody(data: feeds[index].desc, maxLines: 2, shrinkWrap: true, overflow: TextOverflow.ellipsis,),
                                                            ),
                                                          ),
                                                          Align(
                                                            alignment: Alignment.topLeft,
                                                            child: Container(
                                                              margin: EdgeInsets.all(10),
                                                              child: MarkdownBody(data: '![Image](${feeds[index].coverArticle})'),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(height: 10,),
                                                    Container(//komentar box
                                                      child: Container(
                                                        padding: EdgeInsets.only(
                                                            left: 5, right: 5, top: 15, bottom: 5),
                                                        child: Row(
                                                          children: <Widget>[
                                                            Expanded(
                                                              child: Row(
                                                                children: <Widget>[
                                                                  FutureBuilder<UserModel>(
                                                                      future: futureUser,
                                                                      builder: (context, snapshot) {
                                                                        if (snapshot.hasData) {
                                                                          return CircleAvatar(
                                                                            backgroundImage: NetworkImage(
                                                                              (snapshot.data!.profilePicture == null ||
                                                                                  snapshot.data!.profilePicture == "")
                                                                                  ? "https://ceblog.s3.amazonaws.com/wp-content/uploads/2018/08/20142340/best-homepage-9.png"
                                                                                  : '${Config.apiURL}/${snapshot.data!.profilePicture.toString()}',
                                                                            ),
                                                                            radius: 20,
                                                                          );
                                                                        } else
                                                                          return CircularProgressIndicator();
                                                                      }),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Expanded(
                                                                    child: Container(
                                                                      color: Colors.transparent,
                                                                      child: Column(
                                                                        crossAxisAlignment:
                                                                        CrossAxisAlignment.start,
                                                                        children: <Widget>[
                                                                          TextField(
                                                                            style: TextStyle(
                                                                                height: 0.7,
                                                                                fontSize: 15
                                                                            ),
                                                                            readOnly: true,
                                                                            onTap: (){
                                                                              showModalBottomSheet(
                                                                                  isScrollControlled:true,
                                                                                  context: context,
                                                                                  shape: RoundedRectangleBorder(
                                                                                      borderRadius: BorderRadius.vertical(top: Radius.circular(10.0))),
                                                                                  builder: (context) => Padding(
                                                                                    padding: EdgeInsets.only(
                                                                                        bottom: MediaQuery.of(context).viewInsets.bottom),
                                                                                    child: Container(
                                                                                        height: 500,
                                                                                        child: CommentBlockArticle(articleData: feeds[index])
                                                                                    ),
                                                                                  )
                                                                              );
                                                                            },
                                                                            decoration: InputDecoration(
                                                                              border: OutlineInputBorder(
                                                                                borderRadius: BorderRadius.circular(30.0),
                                                                              ),
                                                                              labelText: 'Add comment',
                                                                              isDense: true, // Added this
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ) :
                                              Visibility(
                                                visible: feeds[index].isPublic,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    HeaderFeedCard(postData: feeds[index]),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Align(
                                                      alignment: Alignment.topLeft,
                                                      child: Container(
                                                        margin: EdgeInsets.all(10),
                                                        child: MarkdownBody(fitContent: true,data: feeds[index].desc, ),
                                                      ),
                                                    ),
                                                    Container(//komentar box
                                                      child: Container(
                                                        padding: EdgeInsets.only(
                                                            left: 5, right: 5, top: 15, bottom: 5),
                                                        child: Row(
                                                          children: <Widget>[
                                                            Expanded(
                                                              child: Row(
                                                                children: <Widget>[
                                                                  FutureBuilder<UserModel>(
                                                                      future: futureUser,
                                                                      builder: (context, snapshot) {
                                                                        if (snapshot.hasData) {
                                                                          return CircleAvatar(
                                                                            backgroundImage: NetworkImage(
                                                                              (snapshot.data!.profilePicture == null ||
                                                                                  snapshot.data!.profilePicture == "")
                                                                                  ? "https://ceblog.s3.amazonaws.com/wp-content/uploads/2018/08/20142340/best-homepage-9.png"
                                                                                  : '${Config.apiURL}/${snapshot.data!.profilePicture.toString()}',
                                                                            ),
                                                                            radius: 20,
                                                                          );
                                                                        } else
                                                                          return CircularProgressIndicator();
                                                                      }),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Expanded(
                                                                    child: Container(
                                                                      color: Colors.transparent,
                                                                      child: Column(
                                                                        crossAxisAlignment:
                                                                        CrossAxisAlignment.start,
                                                                        children: <Widget>[
                                                                          TextField(
                                                                            style: TextStyle(
                                                                                height: 0.7,
                                                                                fontSize: 15
                                                                            ),
                                                                            readOnly: true,
                                                                            onTap: (){
                                                                              showModalBottomSheet(
                                                                                  isScrollControlled:true,
                                                                                  context: context,
                                                                                  shape: RoundedRectangleBorder(
                                                                                      borderRadius: BorderRadius.vertical(top: Radius.circular(10.0))),
                                                                                  builder: (context) => Padding(
                                                                                    padding: EdgeInsets.only(
                                                                                        bottom: MediaQuery.of(context).viewInsets.bottom),
                                                                                    child: Container(
                                                                                        height: 500,
                                                                                        child: CommentBlock(postData: feeds[index])
                                                                                    ),
                                                                                  )
                                                                              );
                                                                            },
                                                                            decoration: InputDecoration(
                                                                              border: OutlineInputBorder(
                                                                                borderRadius: BorderRadius.circular(30.0),
                                                                              ),
                                                                              labelText: 'Add comment',
                                                                              isDense: true, // Added this
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )

                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          } else
                            return CircularProgressIndicator();
                        },
                      ),
                    ],
                  ),
                  ListView(
                    children: [
                      Container(),
                       //ProjectFeed(),
                    ],
                  ),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
