import 'package:eportfolio/services/api_service.dart';
import 'package:eportfolio/widgets/custom_appBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:intl/intl.dart';

import '../../models/activity_model.dart';
import '../../view/add_task.dart';

class ActivityTask extends StatefulWidget {
  ActivityTask({Key? key, required this.activityId}) : super(key: key);
  String activityId;

  @override
  State<ActivityTask> createState() => _ActivityTaskState(activityId);
}

class _ActivityTaskState extends State<ActivityTask> {
  String activityId;

  _ActivityTaskState(this.activityId);

  late Future<ActivityModel> futureActivity;

  @override
  void initState() {
    super.initState();
    futureActivity = APIService().fetchSingleActivity(activityId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ActivityModel>(
      future: futureActivity,
      builder: (context,snapshot){
        if(snapshot.hasData){
          return Scaffold(
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 200.0,
                  floating: true,
                  pinned: true,
                  snap: true,
                  actionsIconTheme: IconThemeData(opacity: 0.0),
                  flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      title: Text(snapshot.data!.title,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          )),
                      background: Image.network(
                        snapshot.data!.image,
                        fit: BoxFit.cover,
                      )),
                ),
                SliverFillRemaining(
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.tasks.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        snapshot.data!.tasks.sort((b, a) => a.date.compareTo(b.date));
                        return Card(
                          child: Container(
                            margin: EdgeInsets.all(8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Align(
                                  //title
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                      margin: EdgeInsets.all(10),
                                      child: Text(
                                        snapshot.data!.tasks[index].title, style: TextStyle(fontWeight: FontWeight.bold),
                                      )
                                  ),
                                ),
                                Align(
                                  //date
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      'Created : ${DateFormat.yMMMEd().format(DateTime.parse(snapshot.data!.tasks[index].date))}',
                                      style: TextStyle(fontSize: 12),
                                    ),
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
                                    child: MarkdownBody(
                                        data: snapshot.data!.tasks[index].desc),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 140.0,
                                  child: ListView.builder(
                                    itemCount: snapshot.data!.tasks[index].images.length,
                                    // This next line does the trick.
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, i){
                                      return Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Container(
                                          child: Image.network(snapshot.data!.tasks[index].images[i].imgurl, fit: BoxFit.cover,),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                )
              ],
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                Navigator.push(context , MaterialPageRoute(builder: (context) => AddTask(activityData:snapshot.data!)),
                );
              },
            ),

          );
        } else return CircularProgressIndicator();
      },
    );
  }
}
