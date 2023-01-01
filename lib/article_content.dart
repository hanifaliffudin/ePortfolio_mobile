import 'package:eportfolio/services/api_service.dart';
import 'package:eportfolio/widgets/card/header_article_card.dart';
import 'package:eportfolio/widgets/open_feed/article_card_open.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import 'models/article_model.dart';

class ArticlesContent extends StatefulWidget {
  const ArticlesContent({Key? key}) : super(key: key);

  @override
  State<ArticlesContent> createState() => _ArticlesContentState();
}

class _ArticlesContentState extends State<ArticlesContent> {

  late Future<List<ArticleModel>> futureUserArticle;

  @override
  void initState(){
    super.initState();
    futureUserArticle = APIService().userArticle();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 7,
        ),
        FutureBuilder<List<ArticleModel>>(
            future: futureUserArticle ,
            builder: (context, snapshot){
              if(snapshot.hasData){
                return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Card(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => ProjectCardOpen()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                HeaderArticle(articleData: snapshot.data![index]),
                                const SizedBox(height: 10,),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    margin: EdgeInsets.all(10),
                                    child: MarkdownBody(data: snapshot.data![index].desc),
                                  ),
                                ),
                                const SizedBox(height: 10,),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    margin: EdgeInsets.all(10),
                                    child: Text(snapshot.data![index].title,style: TextStyle(
                                        fontWeight: FontWeight.bold
                                    ),),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                );
              } else return CircularProgressIndicator();
            }
        )
      ],
    );
  }
}
