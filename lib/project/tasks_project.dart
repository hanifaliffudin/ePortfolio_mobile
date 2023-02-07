import 'package:eportfolio/project/add_task_roadmap.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '../models/project_model.dart';

class TasksProject extends StatefulWidget {
  TasksProject({required this.dataRoadmap, required this.dataProject});
  Roadmaps dataRoadmap;
  ProjectModel dataProject;

  @override
  State<TasksProject> createState() => _TasksProjectState(dataRoadmap, dataProject);
}

class _TasksProjectState extends State<TasksProject> {

  Roadmaps dataRoadmap;
  ProjectModel dataProject;
  _TasksProjectState(this.dataRoadmap, this.dataProject);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(dataRoadmap.title,),
      ),
      body: ListView.builder(
          itemCount: dataRoadmap.tasks.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Card(
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
                            dataRoadmap.tasks[index].title, style: TextStyle(fontWeight: FontWeight.bold),
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
                            data: dataRoadmap.tasks[index].desc),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 140.0,
                      child: ListView.builder(
                        itemCount: dataRoadmap.tasks[index].images.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, i){
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              child: Image.network(dataRoadmap.tasks[index].images[i].imgurl, fit: BoxFit.cover,),
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.document_scanner),
        onPressed: () {
          Navigator.push(context , MaterialPageRoute(builder: (context) => AddTaskRoadmap(roadmapsData: dataRoadmap, projectData: dataProject,)),
          );
        },
      ),
    );
  }
}
