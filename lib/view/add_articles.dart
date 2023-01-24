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
  String? idArticle;
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              style:
                              TextButton.styleFrom(backgroundColor: Colors.blue),
                              onPressed: () {},
                              child: Text(
                                'Visibility',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            TextButton(
                              style:
                              TextButton.styleFrom(backgroundColor: Colors.blue),
                              onPressed: () {
                                APIService().updateArticle(idArticle!.toString(), coverArticleController.text, descController.text, titleController.text).then((response) {
                                  if (response) {
                                    Navigator.push(context , MaterialPageRoute(builder: (context) => HomePage(2)),
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
            } else return Column(
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            style:
                            TextButton.styleFrom(backgroundColor: Colors.blue),
                            onPressed: () {},
                            child: Text(
                              'Visibility',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          TextButton(
                            style:
                            TextButton.styleFrom(backgroundColor: Colors.blue),
                            onPressed: () {
                                APIService().createArticle(
                                    titleController.text, descController.text, coverArticleController.text)
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
          },
        ),
      ),
    );
  }
}
