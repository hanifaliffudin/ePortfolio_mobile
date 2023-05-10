import 'package:eportfolio/project/tasks_project.dart';
import 'package:eportfolio/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import '../models/project_model.dart';

class EditTask extends StatefulWidget {
  EditTask({Key? key, required this.roadmapsData, required this.taskData,required this.projectData}) : super(key: key);
  Roadmaps roadmapsData;
  Task taskData;
  ProjectModel projectData;
  @override
  State<EditTask> createState() => _EditTaskState(roadmapsData, taskData ,projectData);
}

class _EditTaskState extends State<EditTask> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController imgController = TextEditingController();
  List<dynamic> images = [];
  List<dynamic> tasks = [];
  List<dynamic> roadmaps = [];
  Roadmaps roadmapsData;
  Task taskData;
  ProjectModel projectData;
  final _formKey = GlobalKey<FormState>();
  _EditTaskState(this.roadmapsData, this.taskData, this.projectData);

  @override
  void initState() {
    super.initState();
    if(taskData.images.isNotEmpty){
      for (int i = 0; i < taskData.images.length; i++) {
        images.add(taskData.images[i]['imgurl']);
      }
    }
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
    titleController.text = taskData.title ?? '';
    descController.text = taskData.desc ?? '';
    startDateController.text= taskData.date ?? '';
    imgController.text = images.join(',');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Task'),
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
                        labelText: 'Task Title',
                        isDense: true,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter description';
                        }
                        return null;
                      },
                      controller: descController,
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Description',
                        isDense: true,
                      ),
                    ),
                    const SizedBox(height: 10,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: SizedBox(
                        width: 125,
                        child: TextField(
                          controller: startDateController,
                          decoration: const InputDecoration(icon: Icon(Icons.calendar_today), //icon of text field
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
                    const SizedBox(height: 20,),
                    TextField(
                      controller: imgController,
                      keyboardType: TextInputType.text,
                      maxLines: 1,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'URL Images',
                        isDense: true,
                      ),
                    ),
                    const SizedBox(height: 5,),
                    Row(
                      children: const [
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
                    const SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          style:
                          TextButton.styleFrom(backgroundColor: Colors.blue),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              List<String> img = imgController.text.split(',');
                              List<dynamic> imeg = [];
                              if (img.isNotEmpty) {
                                for (int i = 0; i < img.length; i++) {
                                  imeg.add({'imgurl': img[i]});
                                }
                              }
                              roadmapsData.tasks.removeWhere((element) => element.title == taskData.title);
                              roadmapsData.tasks.add(Task(title: titleController.text, date: startDateController.text, status: 'done', images: imeg, desc: descController.text, todos: taskData.todos, id: taskData.id));
                              projectData.roadmaps.removeWhere((element) => element.title == roadmapsData.title);
                              projectData.roadmaps.add(Roadmaps(title: roadmapsData.title, startDate: roadmapsData.startDate, endDate: roadmapsData.endDate, desc: roadmapsData.desc, tasks: roadmapsData.tasks, id: roadmapsData.id));
                              APIService()
                                  .updateProjectRoadmap(projectData.roadmaps, projectData.id)
                                  .then((response) => {
                                if (response)
                                  {
                                    FormHelper.showSimpleAlertDialog(
                                      context,
                                      "Success!",
                                      "Success update Task!",
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
                                      "Failed update Task! Please try again",
                                      "OK",
                                          () {
                                        Navigator.of(context).pop();
                                      },
                                    )
                                  }
                              });
                            }
                          },
                          child: const Text(
                            'Edit Task',
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
}
