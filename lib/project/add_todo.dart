import 'package:eportfolio/project/tasks_project.dart';
import 'package:flutter/material.dart';
import 'package:objectid/objectid.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

import '../config.dart';
import '../models/project_model.dart';
import '../models/user_model.dart';
import '../services/api_service.dart';

class AddToDo extends StatefulWidget {
  AddToDo({required this.dataTask, required this.dataRoadmap, required this.dataProject});
  Task dataTask;
  Roadmaps dataRoadmap;
  ProjectModel dataProject;

  @override
  State<AddToDo> createState() => _AddToDoState(dataTask,dataRoadmap,dataProject);
}

class _AddToDoState extends State<AddToDo> {
  TextEditingController titleController = TextEditingController();
  TextEditingController reportController = TextEditingController();
  TextEditingController assigneeController = TextEditingController();
  List<dynamic> assignee = [];
  List<Todos> todos =[];
  List<dynamic> tasks = [];
  List<dynamic> roadmaps = [];
  bool isChecked = false;
  Task dataTask;
  Roadmaps dataRoadmap;
  ProjectModel dataProject;
  late Future<UserModel> futureUser;
  final _formKey = GlobalKey<FormState>();
  _AddToDoState(this.dataTask, this.dataRoadmap, this.dataProject);

  @override
  void initState() {
    super.initState();
    futureUser = APIService().fetchAnyUser();
    if (dataRoadmap.tasks.isNotEmpty) {
      for (int i = 0; i < dataRoadmap.tasks.length; i++) {
        tasks.add(dataRoadmap.tasks[i].toJson());
      }
    }
    if (dataProject.roadmaps.isNotEmpty) {
      for (int i = 0; i < dataProject.roadmaps.length; i++) {
        roadmaps.add(dataProject.roadmaps[i].toJson());
      }
    }
    if (dataTask.todos.isNotEmpty) {
      for (int i = 0; i < dataTask.todos.length; i++) {
        todos.add(Todos(title: dataTask.todos[i].title, done: dataTask.todos[i].done, assignee: dataTask.todos[i].assignee, report: dataTask.todos[i].report, id: dataTask.todos[i].id));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add ToDo'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Color(0xFFF6F6F6),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width :250,
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter asignee at least 1';
                              }
                              return null;
                            },
                            controller: assigneeController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              filled: true,
                              fillColor: Colors.white,
                              labelText: 'Assignee',
                              isDense: true,
                            ),
                          ),
                        ),
                        SizedBox(height: 3,),
                        TextButton( style: TextButton.styleFrom(
                          backgroundColor: Colors.blue,
                          fixedSize: const Size(100, 50),
                        ),onPressed: ()async {
                          await showDialog(
                              context: context,
                              builder:
                                  (_) => participant(dataProject.participants.length));
                        }, child: Text(
                          'Add Asignee', style: TextStyle(
                            color: Colors.white
                        ),
                        ))
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter title';
                        }
                        return null;
                      },
                      controller: titleController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'ToDo Title',
                        isDense: true,
                      ),
                    ),

                    const SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          style:
                          TextButton.styleFrom(backgroundColor: Colors.blue),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                todos.add(Todos(title: titleController.text, done: false, assignee: assignee, report: reportController.text, id: '${ObjectId()}'));
                                dataRoadmap.tasks.removeWhere((element) => element.title == dataTask.title);
                                dataRoadmap.tasks.add(Task(title: dataTask.title, date: dataTask.date, status: 'done', images: dataTask.images, desc: dataTask.desc, todos: todos, id: dataTask.id));
                                roadmaps.removeWhere((element) => element['_id'] == dataRoadmap.id);
                                roadmaps.add(dataRoadmap.toJson());
                                APIService()
                                    .updateProjectRoadmap(roadmaps, dataProject.id)
                                    .then((response) => {
                                  if (response)
                                    {
                                      FormHelper.showSimpleAlertDialog(
                                        context,
                                        "Success!",
                                        "Success create ToDo!",
                                        "OK",
                                            () {
                                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> TasksProject(dataProject: dataProject, dataRoadmap: dataRoadmap)));
                                        },
                                      )
                                    }
                                  else
                                    {
                                      FormHelper.showSimpleAlertDialog(
                                        context,
                                        "Error!",
                                        "Failed create ToDo! Please try again",
                                        "OK",
                                            () {
                                          Navigator.of(context).pop();
                                        },
                                      )
                                    }
                                });
                              });
                            }
                          },
                          child: const Text(
                            'Create ToDo',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget participant(int participant) {
    return FutureBuilder<UserModel>(
      future: futureUser,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          if(participant == 0){
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(20.0),
              ),
              clipBehavior: Clip.antiAlias,
              child: ListView(
                shrinkWrap: true,
                children: [
                  ListTile(
                    title: Center(child: Text('No Participant')),
                  )
                ],
              ),
            );
          }
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(20.0),
            ),
            clipBehavior: Clip.antiAlias,
            child: ListView.builder(
                physics:
                NeverScrollableScrollPhysics(),
                itemCount:
                participant,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return FutureBuilder<UserModel>(
                    future: APIService().fetchAnyUser(dataProject.participants[index]),
                    builder: (context, snapshot){
                      if(snapshot.hasData){
                        return ListTile(
                          title: Text(
                            snapshot.data!.username,
                            style: TextStyle(
                                fontWeight:
                                FontWeight.bold),
                          ),
                          subtitle: Text(
                              snapshot.data!.organization),
                          trailing: IconButton(onPressed: (){
                            assignee.add(dataProject.participants[index]);
                            setState(() {
                              assigneeController.text = assignee.join(',');
                            });
                          }, icon: Icon(Icons.add_box,size: 30,), color: Colors.blue,  ),
                          leading: CircleAvatar(
                              radius: 25,
                              backgroundImage: NetworkImage(
                                (snapshot.data!.profilePicture == null ||
                                    snapshot.data!.profilePicture == "")
                                    ? "https://ceblog.s3.amazonaws.com/wp-content/uploads/2018/08/20142340/best-homepage-9.png"
                                    : '${Config.apiURL}/${snapshot.data!.profilePicture.toString()}',
                              )
                          ),
                        );
                      } else return CircularProgressIndicator();
                    },
                  );
                }),
          );
        } else return CircularProgressIndicator();
      },
    );
  }
}
