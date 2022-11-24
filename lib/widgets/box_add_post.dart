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
                        BottomPopUp(context);
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

void BottomPopUp(context) {
  showModalBottomSheet(
      context: context,
      builder: (context) => Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10))),
          child: Container(
            height: 120,
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.article),
                  title: Text('Add Article'),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>AddArticles()));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.file_copy_sharp),
                  title: Text('Add Project'),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>AddProject()));
                  },
                )
              ],
            ),
          )));
}
