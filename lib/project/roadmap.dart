import 'package:eportfolio/project/add_roadmap.dart';
import 'package:eportfolio/project/tasks_project.dart';
import 'package:eportfolio/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '../models/project_model.dart';

class Roadmap extends StatefulWidget {
  Roadmap({Key? key, required this.projectId}) : super(key: key);
  String projectId;

  @override
  State<Roadmap> createState() => _RoadmapState(projectId);
}

class _RoadmapState extends State<Roadmap> {
  String projectId;

  _RoadmapState(this.projectId);

  late Future<ProjectModel> futureProject;

  @override
  void initState() {
    super.initState();
    futureProject = APIService().fetchSingleProject(projectId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ProjectModel>(
      future: futureProject,
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
                            backgroundColor: Colors.black38,
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
                      itemCount: snapshot.data!.roadmaps.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> TasksProject(dataRoadmap: snapshot.data!.roadmaps[index], dataProject: snapshot.data!)));
                          },
                          child: Card(
                            child: Container(
                              margin: EdgeInsets.all(8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Container(
                                        margin: EdgeInsets.all(10),
                                        child: Text(
                                          snapshot.data!.roadmaps[index].title,style: TextStyle(fontWeight: FontWeight.bold),
                                        )
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
                                          data: snapshot.data!.roadmaps[index].desc),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    height: 140.0,
                                    child: ListView.builder(
                                      itemCount: snapshot.data!.roadmaps[index].tasks.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, i){
                                        return Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Container(

                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
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
                Navigator.push(context , MaterialPageRoute(builder: (context) => AddRoadmap(projectData:snapshot.data!)),
                );
              },
            ),

          );
        } else return CircularProgressIndicator();
      },
    );
  }
}
