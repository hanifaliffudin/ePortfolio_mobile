import 'package:eportfolio/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../../models/article_model.dart';
import '../card/header_article_card.dart';
import '../custom_appBar.dart';

class ArticleCardOpen extends StatefulWidget {
  ArticleCardOpen({Key? key, required this.articleData}) : super(key: key);
  ArticleModel articleData;


  @override
  State<ArticleCardOpen> createState() => _ArticleCardOpenState(articleData);
}

class _ArticleCardOpenState extends State<ArticleCardOpen> {
  ArticleModel articleData;
  _ArticleCardOpenState(this.articleData);

  late Future<ArticleModel> futureArticle;

  @override
  void initState() {
    futureArticle = APIService().fetchSingleArticle(articleData.id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ArticleModel>(
      future: futureArticle,
      builder: (context, snapshot){
        if(snapshot.hasData){
          return Scaffold(
              appBar: CustomAppBar(),
              body: SingleChildScrollView(
                child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            HeaderArticle(articleData: snapshot.data!),
                            const SizedBox(
                              height: 30,
                            ),
                            Text(snapshot.data!.title, //JUDUL
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                                child: snapshot.data!.coverArticle != null ?
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    margin: EdgeInsets.all(1),
                                    child: MarkdownBody(data: '![Image](${snapshot.data!.coverArticle})'),
                                  ),
                                ) :
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    margin: EdgeInsets.all(10),
                                  ),
                                )
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: MarkdownBody(
                                    data : snapshot.data!.desc,
                                ),
                              ),
                            ),
                            SizedBox(height: 5,),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                height: 35,
                                child: ListView.builder(
                                    itemCount: snapshot.data!.tags.length,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, i){
                                      return Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: Container(
                                          child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Text('${snapshot.data!.tags[i]}', style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15
                                            ),),
                                          ), /*Icon(Icons.notifications_rounded, color: Colors.black)*/
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              width: 1,
                                              color: Colors.black12,
                                            ),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                10,
                                              ),
                                            ),
                                            color: Colors.black12,
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            ),
                          ],
                        ))),
              )
          );
        } return CircularProgressIndicator();
      },
    );
  }
}
