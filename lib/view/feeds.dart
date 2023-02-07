import 'package:eportfolio/models/project_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:intl/intl.dart';

import '../config.dart';
import '../models/article_model.dart';
import '../models/user_model.dart';
import '../services/api_service.dart';
import '../widgets/block/comment_block.dart';
import '../widgets/block/comment_block_article.dart';
import '../widgets/box_add_post.dart';
import '../widgets/card/custom_markdown_body.dart';
import '../widgets/card/header_article_card.dart';
import '../widgets/card/header_feed_card.dart';
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
  late Future<List<ProjectModel>> futureProject;

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

  allFeeds(List<dynamic> newFeed) async {
    feeds.addAll(newFeed);
    feeds.sort((b, a) => a.createdAt.compareTo(b.createdAt));
  }

  @override
  void initState() {
    super.initState();
    getAllPost().then((value) => allFeeds(value));
    getAllArticle().then((value) => allFeeds(value));
    futureUser = APIService().fetchAnyUser();
    futureProject = APIService().fetchSuggestProject();
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
                                  child: Stack(children: [
                                    Icon(
                                      Icons.notifications_rounded,
                                      color: Colors.black,
                                      size: 38,
                                    ),
                                    Positioned(
                                      top: 1,
                                      right: 1,
                                      child: Container(
                                        child: Text(
                                          '10',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        /*Icon(Icons.notifications_rounded, color: Colors.black)*/
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                              width: 3,
                                              color: Colors.red,
                                            ),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                50,
                                              ),
                                            ),
                                            color: Colors.red,
                                            boxShadow: [
                                              BoxShadow(
                                                offset: Offset(2, 4),
                                                color: Colors.black.withOpacity(
                                                  0.3,
                                                ),
                                                blurRadius: 3,
                                              ),
                                            ]),
                                      ),
                                    ),
                                  ]),
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
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        children: [
                                          Container(
                                              child:
                                                  feeds[index].runtimeType ==
                                                          ArticleModel
                                                      ? Visibility(
                                                          visible: feeds[index]
                                                              .isPublic,
                                                          child: Column(
                                                            children: [
                                                              HeaderArticle(
                                                                  articleData:
                                                                      feeds[
                                                                          index]),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              GestureDetector(
                                                                onTap: () {
                                                                  Navigator
                                                                      .push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                ArticleCardOpen(articleData: feeds[index])),
                                                                  );
                                                                },
                                                                child: Column(
                                                                  children: [
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child:
                                                                          Container(
                                                                        margin:
                                                                            EdgeInsets.all(10),
                                                                        child:
                                                                            Text(
                                                                          feeds[index]
                                                                              .title,
                                                                          style:
                                                                              TextStyle(fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child:
                                                                          Container(
                                                                        margin: EdgeInsets.only(
                                                                            left:
                                                                                10,
                                                                            right:
                                                                                10,
                                                                            bottom:
                                                                                5),
                                                                        child:
                                                                            CustomMarkdownBody(
                                                                          data:
                                                                              feeds[index].desc,
                                                                          maxLines:
                                                                              2,
                                                                          shrinkWrap:
                                                                              true,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                        child: feeds[index].coverArticle !=
                                                                                null
                                                                            ? Align(
                                                                                alignment: Alignment.topLeft,
                                                                                child: Container(
                                                                                  margin: EdgeInsets.all(1),
                                                                                  child: MarkdownBody(data: '![Image](${feeds[index].coverArticle})'),
                                                                                ),
                                                                              )
                                                                            : Align(
                                                                                alignment: Alignment.topLeft,
                                                                                child: Container(
                                                                                  margin: EdgeInsets.all(10),
                                                                                ),
                                                                              )),
                                                                  ],
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                              Container(
                                                                //komentar box
                                                                child:
                                                                    Container(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              5,
                                                                          right:
                                                                              5,
                                                                          top:
                                                                              15,
                                                                          bottom:
                                                                              5),
                                                                  child: Row(
                                                                    children: <
                                                                        Widget>[
                                                                      Expanded(
                                                                        child:
                                                                            Row(
                                                                          children: <
                                                                              Widget>[
                                                                            FutureBuilder<UserModel>(
                                                                                future: futureUser,
                                                                                builder: (context, snapshot) {
                                                                                  if (snapshot.hasData) {
                                                                                    return CircleAvatar(
                                                                                      backgroundImage: NetworkImage(
                                                                                        (snapshot.data!.profilePicture == null || snapshot.data!.profilePicture == "") ? "https://ceblog.s3.amazonaws.com/wp-content/uploads/2018/08/20142340/best-homepage-9.png" : '${Config.apiURL}/${snapshot.data!.profilePicture.toString()}',
                                                                                      ),
                                                                                      radius: 20,
                                                                                    );
                                                                                  } else
                                                                                    return Center(child: CircularProgressIndicator());
                                                                                }),
                                                                            SizedBox(
                                                                              width: 10,
                                                                            ),
                                                                            Expanded(
                                                                              child: Container(
                                                                                color: Colors.transparent,
                                                                                child: Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: <Widget>[
                                                                                    TextField(
                                                                                      style: TextStyle(height: 0.7, fontSize: 15),
                                                                                      readOnly: true,
                                                                                      onTap: () {
                                                                                        showModalBottomSheet(
                                                                                            isScrollControlled: true,
                                                                                            context: context,
                                                                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(10.0))),
                                                                                            builder: (context) => Padding(
                                                                                                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                                                                                  child: Container(height: 500, child: CommentBlockArticle(articleData: feeds[index])),
                                                                                                ));
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
                                                                        width:
                                                                            10,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      : Visibility(
                                                          visible: feeds[index]
                                                              .isPublic,
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              HeaderFeedCard(
                                                                  postData: feeds[
                                                                      index]),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              Align(
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                                child:
                                                                    Container(
                                                                  margin:
                                                                      EdgeInsets
                                                                          .all(
                                                                              10),
                                                                  child:
                                                                      MarkdownBody(
                                                                    fitContent:
                                                                        true,
                                                                    data: feeds[
                                                                            index]
                                                                        .desc,
                                                                  ),
                                                                ),
                                                              ),
                                                              Container(
                                                                //komentar box
                                                                child:
                                                                    Container(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              5,
                                                                          right:
                                                                              5,
                                                                          top:
                                                                              15,
                                                                          bottom:
                                                                              5),
                                                                  child: Row(
                                                                    children: <
                                                                        Widget>[
                                                                      Expanded(
                                                                        child:
                                                                            Row(
                                                                          children: <
                                                                              Widget>[
                                                                            FutureBuilder<UserModel>(
                                                                                future: futureUser,
                                                                                builder: (context, snapshot) {
                                                                                  if (snapshot.hasData) {
                                                                                    return CircleAvatar(
                                                                                      backgroundImage: NetworkImage(
                                                                                        (snapshot.data!.profilePicture == null || snapshot.data!.profilePicture == "") ? "https://ceblog.s3.amazonaws.com/wp-content/uploads/2018/08/20142340/best-homepage-9.png" : '${Config.apiURL}/${snapshot.data!.profilePicture.toString()}',
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
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: <Widget>[
                                                                                    TextField(
                                                                                      style: TextStyle(height: 0.7, fontSize: 15),
                                                                                      readOnly: true,
                                                                                      onTap: () {
                                                                                        showModalBottomSheet(
                                                                                            isScrollControlled: true,
                                                                                            context: context,
                                                                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(10.0))),
                                                                                            builder: (context) => Padding(
                                                                                                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                                                                                  child: Container(height: 500, child: CommentBlock(postData: feeds[index])),
                                                                                                ));
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
                                                                        width:
                                                                            10,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        )),
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
                      FutureBuilder<List<ProjectModel>>(
                        future: futureProject,
                        builder: (context, snapshot){
                          if(snapshot.hasData){
                            return ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: snapshot.data!.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Container(
                                    child: InkWell(
                                      onTap: (){
                                        /*Navigator.push(context, MaterialPageRoute(builder: (context)=> ActivityTask(activityId: snapshot.data![index].id)));*/
                                      },
                                      child: Card(
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      CircleAvatar(
                                                        backgroundImage: NetworkImage(snapshot.data![index].image != null ? snapshot.data![index].image : 'https://fastly.picsum.photos/id/28/4928/3264.jpg?hmac=GnYF-RnBUg44PFfU5pcw_Qs0ReOyStdnZ8MtQWJqTfA'),
                                                        radius: 25,
                                                      ),
                                                      SizedBox(
                                                        width: 15,
                                                      ),
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Container(
                                                            width: 240,
                                                            child: Text(snapshot.data![index].title, overflow: TextOverflow.ellipsis,
                                                              style: TextStyle(
                                                                fontWeight: FontWeight.bold,
                                                                fontSize: 18,
                                                                color: Colors.blue,
                                                              ),
                                                            ),
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(snapshot.data![index].isPublic == true ? 'Public':'Private',
                                                                style: TextStyle(
                                                                  color: Colors.grey[400],
                                                                ),),
                                                              SizedBox(width: 5,),
                                                              Text(snapshot.data![index].type,
                                                                style: TextStyle(
                                                                  color: Colors.grey[400],
                                                                ),),
                                                            ],
                                                          ),

                                                        ],
                                                      ),
                                                      SizedBox(width: 8,),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(left: 8),
                                                child :Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                    snapshot.data![index].desc,overflow: TextOverflow.ellipsis, maxLines: 3,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 10,),
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  'During ${snapshot.data![index].startDate !=null ? DateFormat.yMMMEd().format(DateTime.parse(snapshot.data![index].startDate)) : ''} - ${snapshot.data![index].endDate !=null ? DateFormat.yMMMEd().format(DateTime.parse(snapshot.data![index].endDate)) : ''}',
                                                  style: TextStyle(
                                                      color: Colors.grey
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 5,),
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Text('Participant(s) ${snapshot.data![index].participants.length}',
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }
                            );
                          }else return CircularProgressIndicator();
                        },
                      )
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
