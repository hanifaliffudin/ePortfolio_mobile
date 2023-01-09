import 'package:comment_box/comment/comment.dart';
import 'package:eportfolio/config.dart';
import 'package:eportfolio/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/user_model.dart';
import '../../services/api_service.dart';
import '../block/comment_block.dart';
import 'header_feed_card.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class PostFeed extends StatefulWidget {
  const PostFeed({Key? key}) : super(key: key);

  @override
  State<PostFeed> createState() => _PostFeedState();
}

class _PostFeedState extends State<PostFeed> {
  late Future<UserModel> futureUser;
  late Future<List<PostModel>> futurePost;

  @override
  void initState() {
    super.initState();
    futureUser = APIService().fetchAnyUser();
    futurePost = APIService().fetchPost();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PostModel>>(
      future : futurePost,
      builder: (context, snapshot){
        if(snapshot.hasData){
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
                            child: MarkdownBody(data: snapshot.data![index].desc),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                        Align(
                          alignment: Alignment.topLeft,
                          child: new Text('Created : ${DateFormat.yMMMEd().format(DateTime.parse(snapshot.data![index].updatedAt))}',
                            style: TextStyle(
                                fontSize: 12
                            ),),
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
                                                        child: CommentBlock(postData: snapshot.data![index])
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
              });
        }else return CircularProgressIndicator();
      }
    );
  }

  String getFormattedDate(String dtStr) {
    var dt = DateTime.parse(dtStr);
    return "${dt.day.toString().padLeft(2,'0')}-${dt.month.toString().padLeft(2,'0')}-${dt.year} ${dt.hour.toString().padLeft(2,'0')}:${dt.minute.toString().padLeft(2,'0')}:${dt.second.toString().padLeft(2,'0')}.${dt.millisecond .toString().padLeft(3,'0')}";
  }
}
