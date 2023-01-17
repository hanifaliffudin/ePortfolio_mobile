import 'package:eportfolio/widgets/custom_appBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:intl/intl.dart';

class ActivityTask extends StatefulWidget {
  const ActivityTask({Key? key}) : super(key: key);

  @override
  State<ActivityTask> createState() => _ActivityTaskState();
}

class _ActivityTaskState extends State<ActivityTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tasks'),
      ),
      body: SingleChildScrollView(
        child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: 5,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Card(
                child: Container(
                  margin: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Align(
                        //title
                        alignment: Alignment.topLeft,
                        child: Container(
                          margin: EdgeInsets.all(10),
                          child: MarkdownBody(
                              data: '## snapshot.data![index].desc'),
                        ),
                      ),
                      Align(
                        widthFactor: 2.5,
                        alignment: Alignment.topLeft,
                        child: new Text(
                          'Date : ${DateFormat.yMMMEd().format(DateTime.now())}',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Align(
                        //desc
                        alignment: Alignment.topLeft,
                        child: Container(
                          margin: EdgeInsets.all(10),
                          child:
                              MarkdownBody(data: 'snapshot.data![index].desc'),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 500,
                        child: Image.network(
                            "https://ceblog.s3.amazonaws.com/wp-content/uploads/2018/08/20142340/best-homepage-9.png"),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}
