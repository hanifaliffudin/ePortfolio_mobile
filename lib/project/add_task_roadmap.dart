import 'package:eportfolio/project/tasks_project.dart';
import 'package:eportfolio/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import '../models/project_model.dart';

class AddTaskRoadmap extends StatefulWidget {
  AddTaskRoadmap({Key? key, required this.roadmapsData, required this.projectData}) : super(key: key);
  Roadmaps roadmapsData;
  ProjectModel projectData;
  @override
  State<AddTaskRoadmap> createState() => _AddTaskRoadmapState(roadmapsData, projectData);
}

class _AddTaskRoadmapState extends State<AddTaskRoadmap> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController imgController = TextEditingController();
  List<dynamic> images = [];
  List<dynamic> tasks = [];
  List<dynamic> roadmaps = [];
  Roadmaps roadmapsData;
  ProjectModel projectData;
  _AddTaskRoadmapState(this.roadmapsData, this.projectData);

  @override
  void initState() {
    super.initState();
    if (roadmapsData.tasks.isNotEmpty) {
      for (int i = 0; i < roadmapsData.tasks.length; i++) {
        tasks.add(roadmapsData.tasks[i].toJson());
      }
    }
    if (projectData.roadmaps.isNotEmpty) {
      for (int i = 0; i < projectData.roadmaps.length; i++) {
        roadmaps.add(projectData.roadmaps[i].toJson());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Task'),
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
              child: Column(
                children: [
                  TextField(
                    controller: titleController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Task Title',
                      isDense: true,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: descController,
                    keyboardType: TextInputType.multiline,
                    maxLines: 5,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Description',
                      isDense: true,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: SizedBox(
                      width: 125,
                      child: TextField(
                        controller: startDateController,
                        decoration: InputDecoration(
                            icon: Icon(Icons.calendar_today), //icon of text field
                            labelText: "Start Date" //label text of field
                        ),
                        readOnly: true,
                        onTap: () async{
                          DateTime? pickedDate = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(2101));
                          if(pickedDate != null) {
                            String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                            setState(() {
                              startDateController.text = formattedDate;
                            });
                          } else {
                            print("Date is not selected");
                          }
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: imgController,
                    keyboardType: TextInputType.text,
                    maxLines: 5,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'URL Images',
                      isDense: true,
                    ),
                  ),
                  SizedBox(height: 5,),
                  Row(
                    children: [
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            '*',
                            style: TextStyle(
                                fontWeight: FontWeight.w300, color: Colors.red),
                          )),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'url separated by coma (,)',
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                            ),
                          )),
                    ],
                  ),
                  SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        style:
                        TextButton.styleFrom(backgroundColor: Colors.blue),
                        onPressed: () {
                          setState(() {
                            List<String> img = imgController.text.split(',');
                            if (img.isNotEmpty) {
                              for (int i = 0; i < img.length; i++) {
                                images.add({'imgurl': '${img[i]}'});
                              }
                            }
                            roadmapsData.tasks.add(Tasks(title: titleController.text, date: startDateController.text, status: 'done', images: images, desc: descController.text, todos: []));
                            roadmaps.removeWhere((element) => element['_id'] == roadmapsData.id);
                            print(roadmaps);
                            roadmaps.add(roadmapsData.toJson());
                            APIService()
                                .updateProjectRoadmap(roadmaps, projectData.id)
                                .then((response) => {
                              if (response)
                                {
                                  FormHelper.showSimpleAlertDialog(
                                    context,
                                    "Success!",
                                    "Success create Roadmap!",
                                    "OK",
                                        () {
                                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> TasksProject(dataProject: projectData, dataRoadmap: roadmapsData,)));
                                    },
                                  )
                                }
                              else
                                {
                                  FormHelper.showSimpleAlertDialog(
                                    context,
                                    "Error!",
                                    "Failed create Roadmap! Please try again",
                                    "OK",
                                        () {
                                      Navigator.of(context).pop();
                                    },
                                  )
                                }
                            });
                          });
                        },
                        child: Text(
                          'Create Task',
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
          ],
        ),
      ),
    );
  }
}
