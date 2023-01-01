import 'package:eportfolio/widgets/open_feed/article_card_open.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '../../models/article_model.dart';
import '../../services/api_service.dart';
import 'header_article_card.dart';

class ArticleFeed extends StatefulWidget {
  const ArticleFeed({Key? key}) : super(key: key);

  @override
  State<ArticleFeed> createState() => _ArticleFeedState();
}

class _ArticleFeedState extends State<ArticleFeed> {

  late Future<List<ArticleModel>> futureArticle;

  @override
  void initState(){
    super.initState();
    futureArticle = APIService().fetchArticle();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder<List<ArticleModel>>(
          future: futureArticle,
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
