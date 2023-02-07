import 'package:eportfolio/project/roadmap.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

import '../models/project_model.dart';
import '../services/api_service.dart';

class AddRoadmap extends StatefulWidget {
  AddRoadmap({Key? key, required this.projectData}) : super(key: key);

  ProjectModel projectData;

  @override
  State<AddRoadmap> createState() => _AddRoadmapState(projectData);
}

class _AddRoadmapState extends State<AddRoadmap> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  List<dynamic> roadmaps = [];
  ProjectModel projectData;

  _AddRoadmapState(this.projectData);

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Roadmap'),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
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
                      SizedBox(
                        width: 125,
                        child: TextField(
                          controller: endDateController,
                          decoration: InputDecoration(
                              icon: Icon(Icons.calendar_today), //icon of text field
                              labelText: "End Date" //label text of field
                          ),
                          readOnly: true,
                          onTap: () async{
                            DateTime? pickedDate = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(2101));
                            if(pickedDate != null) {
                              String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
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
                  TextField(
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
                        style:
                        TextButton.styleFrom(backgroundColor: Colors.blue),
                        onPressed: () {
                          setState(() {
                            roadmaps.add({
                              'title': titleController.text,
                              'startDate': startDateController.text,
                              'endDate' :endDateController.text,
                              'desc': descController.text,
                            });
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
                                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Roadmap(projectId: projectData.id)));
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
                          'Create Roadmap',
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
