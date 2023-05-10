import 'package:eportfolio/services/api_service.dart';
import 'package:eportfolio/widgets/block/comment_block_article.dart';
import 'package:eportfolio/widgets/card/custom_markdown_body.dart';
import 'package:eportfolio/widgets/card/header_article_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import 'config.dart';
import 'models/article_model.dart';
import 'models/user_model.dart';

class ArticleTab extends StatefulWidget {
  const ArticleTab({Key? key}) : super(key: key);

  @override
  State<ArticleTab> createState() => _ArticleTabState();
}

class _ArticleTabState extends State<ArticleTab> {

  late Future<List<ArticleModel>> futureUserArticle;
  late Future<UserModel> futureUser;

  @override
  void initState(){
    super.initState();
    futureUserArticle = APIService().userArticle();
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
            future: futureUserArticle ,
            builder: (context, snapshot){
              if(snapshot.hasData){
                return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              HeaderArticle(articleData: snapshot.data![index]),
                              const SizedBox(height: 10,),
                              GestureDetector(
                                onTap: (){
                                  Navigator.pushNamed(context, '/openArticle', arguments: snapshot.data![index].id);
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
                                          snapshot.data![index]
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
                                        margin: EdgeInsets.only(left:10,right:10,bottom: 5),
                                        child:
                                        CustomMarkdownBody(
                                          data:
                                          snapshot.data![index].desc,
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
                                        child: snapshot.data![index].coverArticle !=
                                            null
                                            ? Align(
                                          alignment: Alignment.topLeft,
                                          child: Container(
                                            margin: EdgeInsets.all(1),
                                            child: MarkdownBody(data: '![Image](${snapshot.data![index].coverArticle})'),
                                          ),
                                        )
                                            : Align(
                                          alignment: Alignment.topLeft,
                                          child: Container(
                                            margin: EdgeInsets.all(10),
                                          ),
                                        )),
                                    SizedBox(height: 5,),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Container(
                                        height: 35,
                                        child: ListView.builder(
                                            itemCount: snapshot.data![index].tags.length,
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, i){
                                              return Padding(
                                                padding: const EdgeInsets.all(3.0),
                                                child: Container(
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(2.0),
                                                    child: Text('${snapshot.data![index].tags[i]}', style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15
                                                    ),),
                                                  ), /*Icon(Icons.notifications_rounded, color: Colors.black)*/
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      width: 1,
                                                      color: Colors.black12,
                                                    ),
                                                    borderRadius: BorderRadius.all(
                                                      Radius.circular(
                                                        10,
                                                      ),
                                                    ),
                                                    color: Colors.black12,
                                                  ),
                                                ),
                                              );
                                            }),
                                      ),
                                    ),
                                  ],
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
