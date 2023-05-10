import 'package:eportfolio/services/api_service.dart';
import 'package:eportfolio/view/home.dart';
import 'package:eportfolio/view/profile.dart';
import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import '../models/article_model.dart';
import '../widgets/custom_appBar.dart';

class AddArticles extends StatefulWidget {
  AddArticles({Key? key, this.id}) : super(key: key);
  String? id;

  @override
  State<AddArticles> createState() => _AddArticlesState(id ?? '');
}

class _AddArticlesState extends State<AddArticles> {
  TextEditingController descController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController coverArticleController = TextEditingController();
  TextEditingController tagsController = TextEditingController();
  List<String> tags = [];
  String? idArticle;
  String? visibility;
  late String choice;
  late Future<ArticleModel> futureArticle;
  _AddArticlesState(this.idArticle);

  @override
  void initState() {
    super.initState();
    futureArticle = APIService().fetchSingleArticle(idArticle);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: FutureBuilder<ArticleModel>(
          future: futureArticle,
          builder: (context, snapshot){
            if(snapshot.hasData){
              descController.text = snapshot.data!.desc ?? '';
              titleController.text = snapshot.data!.title?? '';
              coverArticleController.text = snapshot.data!.coverArticle ?? '';
              tagsController.text = snapshot.data!.tags.join(',') ?? '';
              visibility = snapshot.data!.isPublic.toString();
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
                        TextField(
                          controller: titleController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Title',
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextField(
                          controller: descController,
                          keyboardType: TextInputType.multiline,
                          maxLines: 2,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Write articles',
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
                        TextField(
                          controller: tagsController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Tags',
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text('Add cover image')),
                        SizedBox(
                          height: 7,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(context , MaterialPageRoute(builder: (context) => ProfilePage(5)),
                                  );
                                },
                                style: TextButton.styleFrom(
                                    backgroundColor: Colors.blue),
                                child: Text('Album',
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ),
                            SizedBox(width: 5,),
                            Expanded(
                              child: TextFormField(
                                controller: coverArticleController,
                                decoration: new InputDecoration(
                                  labelText: 'URL image',
                                  contentPadding: EdgeInsets.all(8),
                                  filled: true,
                                  fillColor: Colors.white,
                                  isDense: true,
                                  border: new OutlineInputBorder(
                                      borderSide: new BorderSide(color: Colors.grey)),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Align(alignment : Alignment.topLeft,child: Text('Visibility:')),
                        SizedBox(height: 5,),
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
                                          value: "true",
                                          groupValue: visibility.toString(),
                                          onChanged: (value) {
                                         setState(() {
                                           visibility = value.toString();
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
                                          value: "false",
                                          groupValue: visibility.toString(),
                                          onChanged: (value) {
                                            setState(() {
                                              visibility = value.toString();
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              style:
                              TextButton.styleFrom(backgroundColor: Colors.blue),
                              onPressed: () {
                                List<String> tag = tagsController.text.split(',');
                                if (tag.isNotEmpty) {
                                  for (int i = 0; i < tag.length; i++) {
                                    tags.add(tag[i]);
                                  }
                                }
                                APIService().updateArticle(idArticle!.toString(), coverArticleController.text, descController.text, titleController.text, tags).then((response) {
                                  if (response) {
                                    Navigator.push(context , MaterialPageRoute(builder: (context) => HomePage(0)),
                                    );
                                  } else {
                                    FormHelper.showSimpleAlertDialog(
                                      context,
                                      "Error!",
                                      "Failed update article! Please try again",
                                      "OK",
                                          () {
                                        Navigator.of(context).pop();
                                      },
                                    );
                                  }
                                });
                              },
                              child: Text(
                                'Update Article',
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
            } else {
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
                      TextField(
                        controller: titleController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'Title',
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextField(
                        controller: descController,
                        keyboardType: TextInputType.multiline,
                        maxLines: 5,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Write articles',
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
                      TextField(
                        controller: tagsController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Tags',
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text('Add cover image')),
                      SizedBox(
                        height: 7,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(context , MaterialPageRoute(builder: (context) => ProfilePage(5)),
                                );
                              },
                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.blue),
                              child: Text('Album',
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                          SizedBox(width: 5,),
                          Expanded(
                            child: TextFormField(
                              controller: coverArticleController,
                              decoration: new InputDecoration(
                                labelText: 'URL image',
                                contentPadding: EdgeInsets.all(8),
                                filled: true,
                                fillColor: Colors.white,
                                isDense: true,
                                border: new OutlineInputBorder(
                                    borderSide: new BorderSide(color: Colors.grey)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Align(alignment : Alignment.topLeft,child: Text('Visibility:')),
                      SizedBox(height: 5,),
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
                                        value: "true",
                                        groupValue: visibility,
                                        onChanged: (value) {
                                          setState(() {
                                            visibility = value.toString();
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
                                        value: "false",
                                        groupValue: visibility,
                                        onChanged: (value) {
                                          setState(() {
                                            visibility = value.toString();

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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            style:
                            TextButton.styleFrom(backgroundColor: Colors.blue),
                            onPressed: () {
                              List<String> tag = tagsController.text.split(',');
                              if (tag.isNotEmpty) {
                                for (int i = 0; i < tag.length; i++) {
                                  tags.add(tag[i]);
                                }
                              }
                                APIService().createArticle(
                                    titleController.text, descController.text, coverArticleController.text, tags)
                                    .then((response) {
                                  if (response) {
                                    Navigator.pushNamed(context, '/home');
                                  } else {
                                    FormHelper.showSimpleAlertDialog(
                                      context,
                                      "Error!",
                                      "Failed create article! Please try again",
                                      "OK",
                                          () {
                                        Navigator.of(context).pop();
                                      },
                                    );
                                  }
                                });

                            },
                            child: Text(
                              'Add Article',
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
            }
          },
        ),
      ),
    );
  }
  void buttonValue(String? v) {
    setState(() {
      visibility = v;
    });
  }
}
