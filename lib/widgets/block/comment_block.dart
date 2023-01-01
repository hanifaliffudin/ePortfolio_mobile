import 'dart:convert';

import 'package:comment_box/comment/comment.dart';
import 'package:eportfolio/models/post_response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../../config.dart';
import '../../services/api_service.dart';

class CommentBlock extends StatefulWidget {
  CommentBlock({required this.postData});

  PostResponseModel postData;

  @override
  State<CommentBlock> createState() => _CommentBlockState(postData);
}

class _CommentBlockState extends State<CommentBlock> {
  PostResponseModel postData;

  _CommentBlockState(this.postData);

  var data;
  String? username;
  String? profilePicture;
  var userId;
  List<dynamic> comments = [];

  Future<Map<String, dynamic>> getSinglePost() async {
    final storage = FlutterSecureStorage();
    userId = await storage.read(key: 'userId');
    data = await APIService.getSinglePost(postData.id);
    comments = data['comments'];
    return data;
  }

  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    print(comments);
  }

  /*List comments = [
    {
      'name': 'Chuks Okwuenu',
      'pic': 'https://picsum.photos/300/30',
      'message': 'I love to code',
      'date': '2021-01-01 12:00:00'
    },
    {
      'name': 'Biggi Man',
      'pic': 'https://www.adeleyeayodeji.com/img/IMG_20200522_121756_834_2.jpg',
      'message': 'Very cool',
      'date': '2021-01-01 12:00:00'
    },
    {
      'name': 'Tunde Martins',
      'pic': 'assets/img/userpic.jpg',
      'message': 'Very cool',
      'date': '2021-01-01 12:00:00'
    },
    {
      'name': 'Biggi Man',
      'pic': 'https://picsum.photos/300/30',
      'message': 'Very cool',
      'date': '2021-01-01 12:00:00'
    },
  ];*/

  @override
  Widget build(BuildContext context) {
    return CommentBox(
      userImage: CommentBox.commentImageParser(imageURLorPath: profilePicture),
      labelText: 'Write a comment...',
      errorText: 'Comment cannot be blank',
      withBorder: false,
      sendButtonMethod: () {
        if (formKey.currentState!.validate()) {
          print(commentController.text);
          setState(() {
            var value = {
              'userId': '$userId',
              'comment': commentController.text,
            };
            comments.insert(0, value);
          });
          commentController.clear();
          FocusScope.of(context).unfocus();
        } else {
          print("Not validated");
        }
      },
      formKey: formKey,
      commentController: commentController,
      backgroundColor: Colors.pink,
      textColor: Colors.white,
      sendWidget: Icon(Icons.send_sharp, size: 30, color: Colors.white),
      child: ListView(
        children: [
          for (var i = 0; i < comments.length; i++)
            Padding(
              padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 0.0),
              child: ListTile(
                leading: GestureDetector(
                  onTap: () async {
                    // Display the image in large form.
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
                            imageURLorPath: comments[i]['pic'])),
                  ),
                ),
                title: Text(
                  data[i]['username'],
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(comments[i]['comment']),
                trailing:
                    Text(comments[i]['date'], style: TextStyle(fontSize: 10)),
              ),
            )
        ],
      ),
    );
  }
}
