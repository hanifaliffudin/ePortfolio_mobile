import 'package:eportfolio/widgets/box_add_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '../config.dart';
import '../models/post_response_model.dart';
import '../models/user_model.dart';
import '../services/api_service.dart';
import 'block/comment_block.dart';
import 'card/header_feed_card.dart';

class Activities extends StatefulWidget {
  const Activities({Key? key}) : super(key: key);

  @override
  State<Activities> createState() => _ActivitiesState();
}

class _ActivitiesState extends State<Activities> {
  late Future<List<PostResponseModel>> futureUserPost;
  late Future<UserModel> futureUser;

  @override
  void initState() {
    super.initState();
    futureUserPost = APIService().userPost();
    futureUser = APIService().fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 7,
        ),
        BoxAddPost(),
        FutureBuilder<List<PostResponseModel>>(
            future: futureUserPost,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Container(
                          margin: EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              HeaderFeedCard(postData: snapshot.data![index]),
                              const SizedBox(
                                height: 10,
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  margin: EdgeInsets.all(10),
                                  child: MarkdownBody(
                                      data: snapshot.data![index].desc
                                          .toString()),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: new Text( 'Created : '+
                                  getFormattedDate(snapshot
                                      .data![index].updatedAt
                                      .toString()),
                                ),
                              ),
                              Container(
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
                                                                  child: CommentBlock(postData: snapshot.data![index])
                                                              ),
                                                            )
                                                        );
                                                      },
                                                      decoration: InputDecoration(
                                                        border: OutlineInputBorder(),
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
                                      GestureDetector(
                                        onTap: (){
                                          comment(context);
                                        },
                                        child: Icon(
                                            Icons.send_sharp,
                                            size: 30, color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              } else
                return CircularProgressIndicator();
            })
      ],
    );
  }

  void comment(context) {

  }

  String getFormattedDate(String dtStr) {
    var dt = DateTime.parse(dtStr);
    return "${dt.day.toString().padLeft(2, '0')}-${dt.month.toString().padLeft(2, '0')}-${dt.year} ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}:${dt.second.toString().padLeft(2, '0')}.${dt.millisecond.toString().padLeft(3, '0')}";
  }
}
