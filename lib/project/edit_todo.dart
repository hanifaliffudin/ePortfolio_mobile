import 'package:eportfolio/models/project_model.dart';
import 'package:eportfolio/project/tasks_project.dart';
import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

import '../services/api_service.dart';

class EditToDO extends StatefulWidget {
  EditToDO({required this.dataTodo,required this.dataTask, required this.dataRoadmap, required this.dataProject});
  Todos dataTodo;
  Task dataTask;
  Roadmaps dataRoadmap;
  ProjectModel dataProject;

  @override
  State<EditToDO> createState() => _EditToDOState(dataTodo,dataTask,dataRoadmap,dataProject);
}

class _EditToDOState extends State<EditToDO> {
  Todos dataTodo;
  Task dataTask;
  Roadmaps dataRoadmap;
  ProjectModel dataProject;
  List<Todos> todos =[];
  List<dynamic> roadmaps = [];
  TextEditingController reportController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  _EditToDOState(this.dataTodo, this.dataTask, this.dataRoadmap, this.dataProject);

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
    if (dataTask.todos.isNotEmpty) {
      for (int i = 0; i < dataTask.todos.length; i++) {
        todos.add(Todos(title: dataTask.todos[i].title, done: dataTask.todos[i].done, assignee: dataTask.todos[i].assignee, report: dataTask.todos[i].report, id: dataTask.todos[i].id));
      }
      if (dataProject.roadmaps.isNotEmpty) {
        for (int i = 0; i < dataProject.roadmaps.length; i++) {
          roadmaps.add(dataProject.roadmaps[i].toJson());
        }
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    reportController.text = dataTodo.report ?? '';
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
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your report';
                        }
                        return null;
                      },
                      controller: reportController,
                      keyboardType: TextInputType.text,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Report',
                        alignLabelWithHint: true,
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
                                dataTask.todos.removeWhere((element) => element.title == dataTodo.title);
                                dataTask.todos.add(Todos(title: dataTodo.title, done: true, assignee: dataTodo.assignee, report: reportController.text, id: dataTodo.id));
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
                                        "Success!",
                                        "ToDo done!",
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
                                        "ToDo Error! Please try again",
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
                          child: Row(
                            children: [
                              Text(
                                'Done ToDo ',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              Icon(Icons.check_box, color: Colors.white, size: 20,),
                            ],
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
}
