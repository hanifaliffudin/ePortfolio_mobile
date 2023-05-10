import 'package:eportfolio/project/add_todo.dart';
import 'package:eportfolio/project/edit_todo.dart';
import 'package:eportfolio/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

import '../config.dart';
import '../models/project_model.dart';
import '../models/user_model.dart';

class ToDos extends StatefulWidget {
  ToDos({required this.dataTask, required this.dataRoadmap, required this.dataProject});
  Task dataTask;
  Roadmaps dataRoadmap;
  ProjectModel dataProject;


  @override
  State<ToDos> createState() => _ToDosState(dataTask,dataRoadmap,dataProject);
}

class _ToDosState extends State<ToDos> {
  Task dataTask;
  Roadmaps dataRoadmap;
  ProjectModel dataProject;
  _ToDosState(this.dataTask, this.dataRoadmap, this.dataProject);
  @override

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
        title: Text(dataTask.title,),
      ),
      body: ListView.builder(
          itemCount: dataTask.todos.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final item = dataTask.todos[index].title;
            return Dismissible(
              key: Key(item),
              onDismissed: (direction){
                setState(() {
                  dataTask.todos.removeAt(index);
                  dataRoadmap.tasks.removeWhere((element) => element.title == dataTask.title);
                  dataRoadmap.tasks.add(Task(title: dataTask.title, date: dataTask.date, status: 'done', images: dataTask.images, desc: dataTask.desc, todos: dataTask.todos, id: dataTask.id));
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
                          "ToDo deleted!",
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
                          "Delete ToDo Error! Please try again",
                          "OK",
                              () {
                            Navigator.of(context).pop();
                          },
                        )
                      }
                  });
                });
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$item dismissed')));
              },
              child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> EditToDO(dataTodo: dataTask.todos[index],dataTask: dataTask,dataRoadmap: dataRoadmap,dataProject: dataProject)));
                },
                child: Card(
                  child: Container(
                    margin: EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black54),
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          child: Column(
                            children: [
                              CheckboxListTile(
                                title: Text(dataTask.todos[index].title, style: TextStyle(fontWeight: FontWeight.bold),),
                                value: dataTask.todos[index].done,
                                onChanged: (value) {
                                  setState(() {
                                    print(dataTask.todos[index].done);
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15,),
                        const SizedBox(
                          height: 10,
                        ),
                        Align(
                          //desc
                          alignment: Alignment.topLeft,
                          child: Container(
                            margin: EdgeInsets.all(10),
                            child: MarkdownBody(
                                data: dataTask.todos[index].report != null ? dataTask.todos[index].report  : ''),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Align(alignment: Alignment.topLeft,child: Text('  Assignee :', style: TextStyle(
                          fontWeight: FontWeight.w500
                        ),)),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: dataTask.todos[index].assignee.isEmpty? Container(
                            child: Align(
                              alignment: Alignment.topLeft,
                                child: Text('  no asignee', style: TextStyle(
                                  color: Colors.red
                                ),)),
                          ):
                          Container(
                            height: 50.0,
                            child:  ListView.builder(
                              itemCount: dataTask.todos[index].assignee.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, i){
                                return FutureBuilder<UserModel>(
                                  future: APIService().fetchAnyUser(dataTask.todos[index].assignee[i]),
                                  builder: (context, snapshot){
                                    if(snapshot.hasData){
                                      return Padding(
                                        padding: const EdgeInsets.all(1.0),
                                        child: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                            (snapshot.data!.profilePicture == null ||
                                                snapshot.data!.profilePicture == "")
                                                ? "https://ceblog.s3.amazonaws.com/wp-content/uploads/2018/08/20142340/best-homepage-9.png"
                                                : '${Config.apiURL}/${snapshot.data!.profilePicture.toString()}',
                                          ),
                                          radius: 25,
                                        ),
                                      );
                                    } else return CircularProgressIndicator();
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.edit_note),
        onPressed: () {
          Navigator.push(context , MaterialPageRoute(builder: (context) => AddToDo(dataRoadmap: dataRoadmap,dataProject: dataProject,dataTask: dataTask,)),
          );
        },
      ),
    );
  }
}
