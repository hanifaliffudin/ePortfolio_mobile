import 'package:eportfolio/services/api_service.dart';
import 'package:eportfolio/widgets/block/comment_block.dart';
import 'package:eportfolio/widgets/card/header_article_card.dart';
import 'package:eportfolio/widgets/open_feed/article_card_open.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../../config.dart';
import '../../models/article_model.dart';
import '../../models/user_model.dart';
import '../../widgets/block/comment_block_article.dart';

class FriendArticlesContent extends StatefulWidget {
  FriendArticlesContent({Key? key, required this.userId}) : super(key: key);
  String userId;

  @override
  State<FriendArticlesContent> createState() => _FriendArticlesContentState(userId);
}

class _FriendArticlesContentState extends State<FriendArticlesContent> {
  _FriendArticlesContentState(this.userId);
  String userId;

  late Future<List<ArticleModel>> futureFriendArticle;
  late Future<UserModel> futureUser;

  @override
  void initState(){
    super.initState();
    futureFriendArticle = APIService().friendArticle(userId);
    futureUser = APIService().fetchAnyUser();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 7,
        ),
        FutureBuilder<List<ArticleModel>>(
            future: futureFriendArticle ,
            builder: (context, snapshot){
              if(snapshot.hasData){
                return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        child: InkWell(
                          onTap: () {

                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => ArticleCardOpen(articleData: snapshot.data![index])));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                HeaderArticle(articleData: snapshot.data![index]),
                                const SizedBox(height: 10,),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    margin: EdgeInsets.all(10),
                                    child: MarkdownBody(data: snapshot.data![index].desc),
                                  ),
                                ),
                                const SizedBox(height: 10,),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    margin: EdgeInsets.all(10),
                                    child: Text(snapshot.data![index].title,style: TextStyle(
                                        fontWeight: FontWeight.bold
                                    ),),
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
                                                                    child: CommentBlockArticle(articleData: snapshot.data![index])
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
                          ),
                        ),
                      );
                    }
                );
              } else return CircularProgressIndicator();
            }
        )
      ],
    );
  }
}
