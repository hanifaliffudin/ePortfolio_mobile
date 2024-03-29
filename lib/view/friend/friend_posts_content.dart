import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:intl/intl.dart';
import '../../config.dart';
import '../../models/post_model.dart';
import '../../models/user_model.dart';
import '../../services/api_service.dart';
import '../../widgets/block/comment_block.dart';
import '../../widgets/card/header_feed_card.dart';

class FriendPosts extends StatefulWidget {
  FriendPosts({required this.userId});
  String userId;

  @override
  State<FriendPosts> createState() => _FriendPostsState(userId);
}

class _FriendPostsState extends State<FriendPosts> {
  late Future<List<PostModel>> futureFriendPost;
  late Future<UserModel> futureUser;
  String userId;

  _FriendPostsState(this.userId);

  @override
  void initState() {
    super.initState();
    futureFriendPost = APIService().friendPost(userId);
    futureUser = APIService().fetchAnyUser();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 15,
        ),
        FutureBuilder<List<PostModel>>(
            future: futureFriendPost,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
              } else
                return CircularProgressIndicator();
            })
      ],
    );
  }

  void comment(context) {

  }


}
