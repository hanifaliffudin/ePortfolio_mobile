import 'dart:convert';

import 'package:comment_box/comment/comment.dart';
import 'package:eportfolio/models/article_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../config.dart';
import '../../models/user_model.dart';
import '../../services/api_service.dart';

class CommentBlockArticle extends StatefulWidget {
  const CommentBlockArticle({Key? key,  required this.articleData}) : super(key: key);

  final ArticleModel articleData;

  @override
  State<CommentBlockArticle> createState() => _CommentBlockArticleState(articleData);
}

class _CommentBlockArticleState extends State<CommentBlockArticle> {
  final ArticleModel articleData;
  _CommentBlockArticleState(this.articleData);

  var data;
  String? username;
  String? profilePicture;
  var userId;

  List<dynamic> comments = [];
  late Future<UserModel> futureUser;
  late Future<UserModel> futureFriend;

  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if(articleData.comments.isNotEmpty){
      for(int i = 0;i<articleData.comments.length;i++){
        comments.add(articleData.comments[i].toJson());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel>(
        future: APIService().fetchAnyUser(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return CommentBox(
              userImage: CommentBox.commentImageParser(imageURLorPath: '${Config.apiURL}/${snapshot.data!.profilePicture}'),
              labelText: 'Write a comment...',
              errorText: 'Comment cannot be blank',
              withBorder: false,
              sendButtonMethod: () {
                if (formKey.currentState!.validate()) {
                  print(commentController.text);
                  setState(() {
                   var value = {
                      'userId': snapshot.data!.id,
                      'comment': commentController.text,
                      'date' : DateTime.now().toString()
                    };
                    comments.insert(0, value);
                  });
                  commentController.clear();
                  FocusScope.of(context).unfocus();
                  APIService().updateComment(articleData.userId.toString(), articleData.id.toString(), comments).then((response) =>
                  {
                    if(response){
                      print('berhasil')
                    } else{
                      print('tidak berhasil')
                    }
                  }
                  );
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
                      future: APIService().fetchAnyUser(comments[i]['userId']),
                      builder: (context, snapshot){
                        if(snapshot.hasData){
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
                                    new BorderRadius.all(Radius.circular(50))),
                                child: CircleAvatar(
                                    radius: 50,
                                    backgroundImage: CommentBox.commentImageParser(
                                        imageURLorPath: '${Config.apiURL}/${snapshot.data!.profilePicture}')),
                              ),
                            ),
                            title: Text(
                              snapshot.data!.username,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(comments[i]['comment']),
                            trailing:
                            Text(DateFormat.yMMMEd().format(DateTime.parse(comments[i]['date'])), style: TextStyle(fontSize: 10)),
                          );
                        } else return CircularProgressIndicator();
                      },
                      ),
                    )
                ],
              ),
            );
          } else return CircularProgressIndicator();
        }
    );
  }
}
