import 'dart:convert';

import 'package:comment_box/comment/comment.dart';
import 'package:eportfolio/config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../models/post_model.dart';
import '../../services/api_service.dart';
import 'header_feed_card.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class PostFeed extends StatefulWidget {
  const PostFeed({Key? key}) : super(key: key);

  @override
  State<PostFeed> createState() => _PostFeedState();
}

class _PostFeedState extends State<PostFeed> {
  List<PostModel> postList = [];
  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();

  List filedata = [
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
  ];

  var data;
  String? profilePicture;

  Future<Map<String, dynamic>> getUserData() async {
    data = await APIService.getUserData();
    profilePicture = data['profilePicture'];
    return data;
  }

  Future<void> postTimeline() async {
    await http.get(Uri.parse(Config.timelineApi)).then((value) {
      var data = jsonDecode(value.body);
      for (int i = 0; i < data.length; i++) {
        print('index=${data[i]}');
        postList.add(PostModel(
            data[i]['userId'].toString(),
            data[i]['desc'].toString(),
            data[i]['updatedAt'.toString()],
            data[i]['_id'.toString()],
            data[i]['comments']));
      }

      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    postTimeline();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: postList.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Card(
            child: Container(
              margin: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  HeaderFeedCard(postData: postList[index]),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: MarkdownBody(data: postList[index].desc.toString()),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                 /* Container(margin: EdgeInsets.all(10), child: Text('')
                      //Image(image: NetworkImage('https://ceblog.s3.amazonaws.com/wp-content/uploads/2018/08/20142340/best-homepage-9.png')),
                      ),
                  const SizedBox(
                    height: 10,
                  ),*/
                  Align(
                    alignment: Alignment.topLeft,
                    child: new Text('Created : ${getFormattedDate(postList[index].updatedAt.toString())}',
                    style: TextStyle(
                      fontSize: 12
                    ),),
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
                                FutureBuilder(
                                    future: getUserData(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return CircleAvatar(
                                          backgroundImage: NetworkImage(
                                            (profilePicture == null ||
                                                    profilePicture == "")
                                                ? "https://ceblog.s3.amazonaws.com/wp-content/uploads/2018/08/20142340/best-homepage-9.png"
                                                : '${Config.apiURL}/${profilePicture.toString()}',
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
                                            comment(context);
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
  }

  Widget commentChild(data) {
    return ListView(
      children: [
        for (var i = 0; i < data.length; i++)
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
                      borderRadius: new BorderRadius.all(Radius.circular(50))),
                  child: CircleAvatar(
                      radius: 50,
                      backgroundImage: CommentBox.commentImageParser(
                          imageURLorPath: data[i]['pic'])),
                ),
              ),
              title: Text(
                data[i]['name'],
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(data[i]['message']),
              trailing: Text(data[i]['date'], style: TextStyle(fontSize: 10)),
            ),
          )
      ],
    );
  }

  void comment(context) {
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
                  child: CommentBox(
                userImage: CommentBox.commentImageParser(
                    imageURLorPath: "assets/img/userpic.jpg"),
                child: commentChild(filedata),
                labelText: 'Write a comment...',
                errorText: 'Comment cannot be blank',
                withBorder: false,
                sendButtonMethod: () {
                  if (formKey.currentState!.validate()) {
                    print(commentController.text);
                    setState(() {
                      var value = {
                        'name': 'New User',
                        'pic':
                            'https://lh3.googleusercontent.com/a-/AOh14GjRHcaendrf6gU5fPIVd8GIl1OgblrMMvGUoCBj4g=s400',
                        'message': commentController.text,
                        'date': '2021-01-01 12:00:00'
                      };
                      filedata.insert(0, value);
                    });
                    commentController.clear();
                    FocusScope.of(context).unfocus();
                  } else {
                    print("Not validated");
                  }
                },
                formKey: formKey,
                commentController: commentController,
                backgroundColor: Colors.blue,
                textColor: Colors.white,
                sendWidget: Icon(Icons.send_sharp, size: 30, color: Colors.white),
              )
          ),
        )
    );
  }

  String getFormattedDate(String dtStr) {
    var dt = DateTime.parse(dtStr);
    return "${dt.day.toString().padLeft(2,'0')}-${dt.month.toString().padLeft(2,'0')}-${dt.year} ${dt.hour.toString().padLeft(2,'0')}:${dt.minute.toString().padLeft(2,'0')}:${dt.second.toString().padLeft(2,'0')}.${dt.millisecond .toString().padLeft(3,'0')}";
  }
}
