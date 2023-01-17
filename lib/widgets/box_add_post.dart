import 'package:eportfolio/services/api_service.dart';
import 'package:eportfolio/view/add_articles.dart';
import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

class BoxAddPost extends StatefulWidget {
  const BoxAddPost({Key? key}) : super(key: key);

  @override
  State<BoxAddPost> createState() => _BoxAddPostState();
}

class _BoxAddPostState extends State<BoxAddPost> {

  TextEditingController descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
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
                      Navigator.pushNamed(context, '/home');
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