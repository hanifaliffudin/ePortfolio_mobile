import 'package:eportfolio/view/add_articles.dart';
import 'package:flutter/material.dart';
import '../view/add_project.dart';

class BoxAddPost extends StatefulWidget {
  const BoxAddPost({Key? key}) : super(key: key);

  @override
  State<BoxAddPost> createState() => _BoxAddPostState();
}

class _BoxAddPostState extends State<BoxAddPost> {

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
            keyboardType: TextInputType.multiline,
            maxLines: 2,
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
                  IconButton(onPressed: () {}, icon: Icon(Icons.image)),
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
                onPressed: () {},
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