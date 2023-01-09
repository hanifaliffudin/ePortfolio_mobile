import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../../models/article_model.dart';
import '../custom_appBar.dart';

class ArticleCardOpen extends StatefulWidget {
  const ArticleCardOpen({Key? key}) : super(key: key);


  @override
  State<ArticleCardOpen> createState() => _ArticleCardOpenState();
}

class _ArticleCardOpenState extends State<ArticleCardOpen> {

  get raisedButtonStyle => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Container(
          padding: const EdgeInsets.all(8),
          child: Card(
              child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      // HeaderArticle(articleData: snapshot.data![index]),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('snapshot.data!.title', //JUDUL
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
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          margin: EdgeInsets.all(10),
                          child: MarkdownBody(data: '![Image](${'snapshot.data!.coverArticle'})'),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                       " snapshot.data!.desc,"
                      ),
                    ],
                  ))))
    );
  }
}
