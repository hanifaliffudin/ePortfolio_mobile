import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

import '../models/activity_model.dart';
import '../models/post_model.dart';
import '../services/api_service.dart';
import '../widgets/card/activity_task.dart';

class AddTask extends StatefulWidget {
  AddTask({Key? key, required this.activityData}) : super(key: key);

  ActivityModel activityData;

  @override
  State<AddTask> createState() => _AddTaskState(activityData);
}

class _AddTaskState extends State<AddTask> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController imgController = TextEditingController();
  String? type;
  List<dynamic> images = [];
  List<dynamic> tasks = [];
  ActivityModel activityData;

  _AddTaskState(this.activityData);

  @override
  void initState() {
    super.initState();
    if (activityData.tasks.isNotEmpty) {
      for (int i = 0; i < activityData.tasks.length; i++) {
        tasks.add(activityData.tasks[i].toJson());
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
                      labelText: 'Activity Title',
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
                      labelText: 'Activity description',
                      isDense: true,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
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
                  SizedBox(
                    height: 5,
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
                            print(images);
                            tasks.add({
                              'title': '${titleController.text}',
                              'date': '${DateTime.now()}',
                              'desc': '${descController.text}',
                              'images': images
                            });
                            APIService()
                                .updateActivityTask(tasks, activityData.id)
                                .then((response) => {
                                      if (response)
                                        {
                                          FormHelper.showSimpleAlertDialog(
                                            context,
                                            "Success!",
                                            "Success create tasks!",
                                            "OK",
                                            () {
                                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> ActivityTask(activityId: activityData.id)));
                                            },
                                          )
                                        }
                                      else
                                        {
                                          FormHelper.showSimpleAlertDialog(
                                            context,
                                            "Error!",
                                            "Failed upload image! Please try again",
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
