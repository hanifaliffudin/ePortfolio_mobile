import 'package:eportfolio/project/roadmap.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

import '../models/project_model.dart';
import '../services/api_service.dart';

class EditRoadmap extends StatefulWidget {
  EditRoadmap({Key? key, required this.projectData, required this.roadmapData}) : super(key: key);
  ProjectModel projectData;
  Roadmaps roadmapData;

  @override
  State<EditRoadmap> createState() => _EditRoadmapState(projectData,roadmapData);
}

class _EditRoadmapState extends State<EditRoadmap> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  List<dynamic> roadmaps = [];
  ProjectModel projectData;
  Roadmaps roadmapData;
  final _formKey = GlobalKey<FormState>();

  _EditRoadmapState(this.projectData, this.roadmapData);

  @override
  void initState() {
    super.initState();
    if (projectData.roadmaps.isNotEmpty) {
      for (int i = 0; i < projectData.roadmaps.length; i++) {
        roadmaps.add(projectData.roadmaps[i].toJson());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    titleController.text = roadmapData.title ?? '';
    descController.text = roadmapData.desc ?? '';
    startDateController.text = roadmapData.startDate ?? '';
    endDateController.text = roadmapData.endDate ?? '';
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit ${roadmapData.title}'),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 125,
                          child: TextField(
                            controller: startDateController,
                            decoration: InputDecoration(
                                icon: Icon(Icons.calendar_today),
                                //icon of text field
                                labelText: "Start Date" //label text of field
                            ),
                            readOnly: true,
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2101));
                              if (pickedDate != null) {
                                String formattedDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                                setState(() {
                                  startDateController.text = formattedDate;
                                });
                              } else {
                                print("Date is not selected");
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          width: 125,
                          child: TextField(
                            controller: endDateController,
                            decoration: InputDecoration(
                                icon: Icon(Icons.calendar_today),
                                //icon of text field
                                labelText: "End Date" //label text of field
                            ),
                            readOnly: true,
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2101));
                              if (pickedDate != null) {
                                String formattedDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                                setState(() {
                                  endDateController.text = formattedDate;
                                });
                              } else {
                                print("Date is not selected");
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
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
                        labelText: 'Roadmap description',
                        isDense: true,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.blue),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                projectData.roadmaps.removeWhere((element) => element.title == roadmapData.title);
                                projectData.roadmaps.add(Roadmaps(id: roadmapData.id, title: titleController.text, desc: descController.text, endDate: endDateController.text, startDate: startDateController.text,tasks: roadmapData.tasks));
                                APIService()
                                    .updateProjectRoadmap(
                                    projectData.roadmaps, projectData.id)
                                    .then((response) => {
                                  if (response)
                                    {
                                      FormHelper.showSimpleAlertDialog(
                                        context,
                                        "Success!",
                                        "Success update Roadmap!",
                                        "OK",
                                            () {
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Roadmap(
                                                          projectId:
                                                          projectData
                                                              .id)));
                                        },
                                      )
                                    }
                                  else
                                    {
                                      FormHelper.showSimpleAlertDialog(
                                        context,
                                        "Error!",
                                        "Failed update Roadmap! Please try again",
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
                          child: Text(
                            'Update Roadmap',
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
