import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import '../models/activity_model.dart';
import '../services/api_service.dart';

class EditTasks extends StatefulWidget {
  EditTasks({Key? key, required this.dataTask, required this.dataActivity}) : super(key: key);
  ActivityModel dataActivity;
  Tasks dataTask;
  @override
  State<EditTasks> createState() => _EditTasksState(dataTask, dataActivity);
}

class _EditTasksState extends State<EditTasks> {

  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController imgController = TextEditingController();
  List<dynamic> images = [];
  List<dynamic> tasks = [];
  final _formKey = GlobalKey<FormState>();
  Tasks dataTask;
  ActivityModel dataActivity;
  _EditTasksState(this.dataTask, this.dataActivity);

  @override
  void initState() {
    super.initState();
    if(dataTask.images.isNotEmpty){
      for (int i = 0; i < dataTask.images.length; i++) {
        images.add(dataTask.images[i]['imgurl']);
      }
    }
    if (dataActivity.tasks.isNotEmpty) {
      for (int i = 0; i < dataActivity.tasks.length; i++) {
        tasks.add(dataActivity.tasks[i].toJson());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    titleController.text = dataTask.title ?? '';
    descController.text = dataTask.desc ?? '';
    imgController.text = images.join(',');
    return Scaffold(
      appBar: AppBar(
        title: Text('Update ${dataTask.title}'),
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
                  Form(
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
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'Activity description',
                            isDense: true,
                          ),
                        ),
                      ],
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
                      hintText: 'URL Images',
                      isDense: true,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        style:
                        TextButton.styleFrom(backgroundColor: Colors.blue),
                        onPressed: () {
                          List<String> img = imgController.text.split(',');
                          List<dynamic> imeg = [];
                          if (img.isNotEmpty) {
                            for (int i = 0; i < img.length; i++) {
                              imeg.add({'imgurl': img[i]});
                            }
                          }
                          dataActivity.tasks.removeWhere((element) => element.title == dataTask.title);
                          dataActivity.tasks.add(Tasks(title: titleController.text, date: DateTime.now().toString(), desc: descController.text, images: imeg, id: dataTask.id));
                          APIService()
                              .updateActivityTask(dataActivity.tasks, dataActivity.id)
                              .then((response) => {
                            if (response)
                              {
                                FormHelper.showSimpleAlertDialog(
                                  context,
                                  "Success!",
                                  "Success update Task!",
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
                                  "Failed update Task! Please try again",
                                  "OK",
                                      () {
                                    Navigator.of(context).pop();
                                  },
                                )
                              }
                          });
                        },
                        child: Text(
                          'Update Task',
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
