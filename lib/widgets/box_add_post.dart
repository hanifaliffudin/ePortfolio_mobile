import 'package:eportfolio/services/api_service.dart';
import 'package:eportfolio/view/add_articles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

import '../view/home.dart';

class BoxAddPost extends StatefulWidget {
  const BoxAddPost({Key? key}) : super(key: key);

  @override
  State<BoxAddPost> createState() => _BoxAddPostState();
}

class _BoxAddPostState extends State<BoxAddPost> {
  final storage = FlutterSecureStorage();
  TextEditingController descController = TextEditingController();
  String? jwt;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      height: 150,
      padding: EdgeInsets.all(10),
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey[200],
      ),
      child: Column(
        children: [
          TextField(
            controller: descController,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Colors.white,
              hintText: 'What is going on?',
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  IconButton(onPressed: () {

                  }, icon: Icon(Icons.image)),
                  IconButton(
                      onPressed: () {}, icon: Icon(Icons.video_file)),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>AddArticles()));
                        //BottomPopUp(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text('Add Articles'),
                              Icon(Icons.article),
                            ],
                          )
                        ],
                      )),
                ],
              ),
              TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.blue),
                onPressed: () {
                  APIService.createPost(descController.text).then((response)
                  {
                    if(response){
                      setState(() {
                      });
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomePage(jwt ?? '')));
                    } else {
                      FormHelper.showSimpleAlertDialog(
                        context,
                        "Error!",
                        "Failed create post! Please try again",
                        "OK",
                            () {
                          Navigator.of(context).pop();
                        },
                      );
                    }
                  }
                  );
                },
                child: Text(
                  'Post',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}