import 'package:comment_box/comment/comment.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

import '../../config.dart';
import '../../models/post_model.dart';
import '../../models/user_model.dart';
import '../../services/api_service.dart';

class CommentBlock extends StatefulWidget {
  const CommentBlock({Key? key, required this.postData}) : super(key: key);
  final PostModel postData;

  @override
  State<CommentBlock> createState() => _CommentBlockState(postData);
}

class _CommentBlockState extends State<CommentBlock> {
  final PostModel postData;
  _CommentBlockState(this.postData);
  var data;
  String? username;
  String? profilePicture;
  var userId;

  List<dynamic> comments = [];
  late Future<UserModel> futureUser;

  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    futureUser = APIService().fetchAnyUser();
    if (postData.comments.isNotEmpty) {
      for (int i = 0; i < postData.comments.length; i++) {
        comments.add(postData.comments[i].toJson());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel>(
        future: futureUser,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return CommentBox(
              userImage: CommentBox.commentImageParser(imageURLorPath: '${Config
                  .apiURL}/${snapshot.data!.profilePicture}'),
              labelText: 'Write a comment...',
              errorText: 'Comment cannot be blank',
              withBorder: false,
              sendButtonMethod: () async {
                if (formKey.currentState!.validate()) {
                  setState(() {
                    var value = {
                      'userId': snapshot.data!.id,
                      'date': DateTime.now().toString(),
                      'comment': commentController.text,
                    };
                    comments.insert(0, value);
                  });
                  commentController.clear();
                  FocusScope.of(context).unfocus();
                  await APIService().updateCommentPost(
                      postData.userId.toString(), postData.id.toString(),
                      comments).then((response) =>
                  {
                  if(response){
                  } else{
                    FormHelper.showSimpleAlertDialog(
                    context,
                    "Error!",
                    "Failed create comment! Please try again",
                    "OK",
                        () {
                      Navigator.of(context).pop();
                    },
                  )
                }
              });
                } else {
                print("Not validated");
                }
              },
              formKey: formKey,
              commentController: commentController,
              backgroundColor: Colors.white,
              textColor: Colors.black,
              sendWidget: Icon(Icons.send_sharp, size: 30, color: Colors.black),
              child: ListView(
                children: [
                  for (var i = 0; i < comments.length; i++)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 0.0),
                      child: FutureBuilder<UserModel>(
                        future: APIService().fetchAnyUser(
                            comments[i]['userId']),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListTile(
                              leading: GestureDetector(
                                onTap: () async {
                                  print("Comment Clicked");
                                },
                                child: Container(
                                  height: 50.0,
                                  width: 50.0,
                                  decoration: new BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius:
                                      new BorderRadius.all(
                                          Radius.circular(50))),
                                  child: CircleAvatar(
                                      radius: 50,
                                      backgroundImage: CommentBox
                                          .commentImageParser(
                                          imageURLorPath: '${Config
                                              .apiURL}/${snapshot.data!
                                              .profilePicture}')),
                                ),
                              ),
                              title: Text(
                                snapshot.data!.username,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(comments[i]['comment']),
                              trailing:
                              Text(DateFormat.yMMMEd().format(
                                  DateTime.parse(comments[i]['date'])),
                                  style: TextStyle(fontSize: 10)),
                            );
                          } else
                            return CircularProgressIndicator();
                        },
                      ),
                    )
                ],
              ),
            );
          } else
            return CircularProgressIndicator();
        }
    );
  }
}
