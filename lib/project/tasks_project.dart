import 'package:eportfolio/project/add_task_roadmap.dart';
import 'package:eportfolio/project/todos.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:intl/intl.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import '../models/project_model.dart';
import '../services/api_service.dart';
import 'edit_task.dart';

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
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/project');
                },
                child: Icon(
                  Icons.home,
                  size: 26.0,
                ),
              )
          ),
        ],
        title: Text(dataRoadmap.title,),
      ),
      body: Column(
        children: [
          Container(
            child: Card(
              color: Colors.grey[200],
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Roadmap description',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ],
                            ),
                          ],
                        ),
                        TextButton(
                            onPressed: ()async {
                              await showDialog(
                                  context: context,
                                  builder:
                                      (_) => moreInformation());
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll<Color>(Colors.blue),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                            child: Text('More information', style: TextStyle(color: Colors.white),))
                      ],
                    ),
                    SizedBox(height: 5,),
                    Column(
                      children: <Widget>[
                        Align(
                          child: Container(
                              padding: EdgeInsets.only(
                                  right: 10,
                                  left: 10,
                                  top: 10,
                                  bottom: 10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                  BorderRadius.circular(10)),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      dataRoadmap.desc,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 5,
                                      style: TextStyle(
                                          fontWeight:
                                          FontWeight.w400,
                                          fontSize: 15),
                                    ),
                                  ],
                                ),
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: dataRoadmap.tasks.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  dataRoadmap.tasks.sort((b, a) => a.date.compareTo(b.date));
                  return InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> ToDos(dataTask: dataRoadmap.tasks[index], dataRoadmap: dataRoadmap, dataProject: dataProject)));
                    },
                    child: Card(
                      child: Container(
                        margin: EdgeInsets.all(8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 5.0,right: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    dataRoadmap.tasks[index].title, style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(width: 5,),
                                  InkWell(
                                      onTap:(){
                                          showModalBottomSheet(
                                              context: context,
                                              builder: (context) => Container(
                                                height: 100,
                                                margin: EdgeInsets.only(left: 10, top: 10, right: 10),
                                                child: Column(
                                                  children: [
                                                    ElevatedButton(
                                                        style: ElevatedButton.styleFrom(),
                                                        onPressed: () {
                                                          setState(() {
                                                            dataRoadmap.tasks.removeWhere((element) => element.title == dataRoadmap.tasks[index].title);
                                                            dataProject.roadmaps.removeWhere((element) => element.title == dataRoadmap.title);
                                                            dataProject.roadmaps.add(Roadmaps(title: dataRoadmap.title, startDate: dataRoadmap.startDate, endDate: dataRoadmap.endDate, desc: dataRoadmap.desc, tasks: dataRoadmap.tasks, id: dataRoadmap.id));
                                                            APIService()
                                                                .updateProjectRoadmap(dataProject.roadmaps, dataProject.id)
                                                                .then((response) => {
                                                              if (response)
                                                                {
                                                                  FormHelper.showSimpleAlertDialog(
                                                                    context,
                                                                    "Deleted!",
                                                                    "Task deleted!",
                                                                    "OK",
                                                                        () {
                                                                      Navigator.of(context).pop();
                                                                    },
                                                                  )
                                                                }
                                                              else
                                                                {
                                                                  FormHelper.showSimpleAlertDialog(
                                                                    context,
                                                                    "Error!",
                                                                    "Delete Task Error! Please try again",
                                                                    "OK",
                                                                        () {
                                                                      Navigator.of(context).pop();
                                                                    },
                                                                  )
                                                                }
                                                            });
                                                          });
                                                        },
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [Text('Delete'), Icon(Icons.delete)],
                                                        )),
                                                    ElevatedButton(
                                                        style: ElevatedButton.styleFrom(),
                                                        onPressed: () {
                                                          Navigator.push(context , MaterialPageRoute(builder: (context) => EditTask(roadmapsData: dataRoadmap, projectData: dataProject, taskData: dataRoadmap.tasks[index],)),
                                                          );
                                                        },
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [Text('Edit'), Icon(Icons.edit)],
                                                        )),
                                                  ],
                                                ),
                                              ));

                                      },child: Icon(Icons.more_horiz))
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Align(
                              //desc
                              alignment: Alignment.topLeft,
                              child: dataRoadmap.tasks[index].desc == null? Container():
                              Container(
                                margin: EdgeInsets.all(10),
                                child: MarkdownBody(
                                    data: dataRoadmap.tasks[index].desc),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: dataRoadmap.tasks[index].images.isEmpty?
                              Container():
                              Container(
                                height: 140,
                                child: ListView.builder(
                                  itemCount: dataRoadmap.tasks[index].images.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, i){
                                    return Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Container(
                                        child: Image.network(dataRoadmap.tasks[index].images[i]['imgurl'], fit: BoxFit.cover,height: 140,),
                                      ),
                                    );
                                  },
                                ),
                              )
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.document_scanner),
        onPressed: () {
          Navigator.push(context , MaterialPageRoute(builder: (context) => AddTaskRoadmap(roadmapsData: dataRoadmap, projectData: dataProject,)),
          );
        },
      ),
    );
  }
  Widget moreInformation() {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius:
        BorderRadius.circular(20.0),
      ),
      clipBehavior: Clip.antiAlias,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: Colors.grey[200],
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize :MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Detail Information',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    IconButton(color : Colors.grey[200],onPressed: () {}, icon: Icon(Icons.more_horiz))
                  ],
                ),
                Container(
                    padding:
                    EdgeInsets.only(right: 12, left: 10, top: 10, bottom: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Task Title : ' , style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),
                            )
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 250,
                              child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    dataRoadmap.title,
                                  )
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Start date : ' , style: TextStyle(
                                    fontWeight: FontWeight.bold
                                ),
                                )
                            ),
                            Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  '${dataRoadmap.startDate !=null ? DateFormat.yMMMEd().format(DateTime.parse(dataRoadmap.startDate)) : ''}' , style: TextStyle(
                                ),
                                )
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'End date : ' , style: TextStyle(
                                    fontWeight: FontWeight.bold
                                ),
                                )
                            ),
                            Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  '${dataRoadmap.endDate !=null ? DateFormat.yMMMEd().format(DateTime.parse(dataRoadmap.endDate)) : ''}' , style: TextStyle(
                                ),
                                )
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Description : ' , style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),
                            )
                        ),
                        SizedBox(height: 5,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 250,
                              child: Align(
                                  alignment: Alignment.topLeft,
                                  child: MarkdownBody(
                                    data :dataRoadmap.desc,
                                  )
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
