import 'package:eportfolio/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

import '../models/post_model.dart';
import '../view/home.dart';

class EditPost extends StatefulWidget {
  EditPost({Key? key, this.idPost}) : super(key: key);
  String? idPost;

  @override
  State<EditPost> createState() => _EditPostState(idPost ?? '');
}

class _EditPostState extends State<EditPost> {
  TextEditingController descController = TextEditingController();
  bool? visibility;
  late Future<PostModel> futurePost;
  String? idPost;
  _EditPostState(this.idPost);

  @override
  void initState() {
    super.initState();
    futurePost = APIService().fetchSinglePost(idPost);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Post"),),
      body: FutureBuilder<PostModel>(
        future : futurePost,
        builder : (context, snapshot){
          if (snapshot.hasData){
            descController.text = snapshot.data!.desc ?? '';
            visibility = snapshot.data!.isPublic;
            return Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color(0xFFF6F6F6),
                  ),
                  child: Column(
                    children: [
                      Align(alignment : Alignment.topLeft,child: Text('Description:')),
                      SizedBox(height: 10,),
                      TextField(
                        controller: descController,
                        keyboardType: TextInputType.multiline,
                        maxLines: 2,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Update post',
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color(0xFFF6F6F6),
                  ),
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(5),
                  child: Column(
                    children: [
                      Align(alignment : Alignment.topLeft,child: Text('Visibility:')),
                      SizedBox(height: 10,),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black54),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                    child: ListTile(
                                      title:  Transform.translate(
                                        offset: Offset(-25, 0),
                                        child:  Text("Public",style: TextStyle(
                                            fontSize: 12, fontWeight: FontWeight.bold
                                        )),
                                      ),
                                      leading: Radio(
                                        fillColor: MaterialStateColor.resolveWith(
                                                (states) => Color(0XFFB63728)),
                                        value: true,
                                        groupValue: visibility,
                                        onChanged: (value) {
                                          setState(() {
                                            visibility = true;
                                          });
                                        },
                                      ),
                                      trailing:  Transform.translate(
                                        offset: Offset(-50, 0),
                                        child: Icon(Icons.visibility),
                                      ),
                                    )),
                                Expanded(
                                    child: ListTile(
                                      title:  Transform.translate(
                                        offset: Offset(-25, 0),
                                        child:  Text("Private",style: TextStyle(
                                            fontSize: 12, fontWeight: FontWeight.bold
                                        )),
                                      ),
                                      leading: Radio(
                                        fillColor: MaterialStateColor.resolveWith(
                                                (states) => Color(0XFFB63728)),
                                        value: false,
                                        groupValue: visibility,
                                        onChanged: (value) {
                                          setState(() {
                                            visibility = false;
                                          });
                                        },
                                      ),
                                      trailing:  Transform.translate(
                                        offset: Offset(-45, 0),
                                        child: Icon(Icons.visibility_off),
                                      ),
                                    ))
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            style:
                            TextButton.styleFrom(backgroundColor: Colors.blue),
                            onPressed: () {
                              APIService().updatePost(idPost!, descController.text, visibility!).then((response) {
                                if (response) {
                                  Navigator.push(context , MaterialPageRoute(builder: (context) => HomePage(0)),
                                  );
                                } else {
                                  FormHelper.showSimpleAlertDialog(
                                    context,
                                    "Error!",
                                    "Failed update post! Please try again",
                                    "OK",
                                        () {
                                      Navigator.of(context).pop();
                                    },
                                  );
                                }
                              });
                            },
                            child: Text(
                              'Update',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else return Center(child: CircularProgressIndicator(),);
        }

      ),
    );
  }
}
