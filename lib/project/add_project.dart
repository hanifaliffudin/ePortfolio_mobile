import 'package:eportfolio/view/profile.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import '../services/api_service.dart';
import '../widgets/custom_appBar.dart';
import '../view/home.dart';

class AddProject extends StatefulWidget {
  const AddProject({Key? key}) : super(key: key);

  @override
  State<AddProject> createState() => _AddProjectState();
}

class _AddProjectState extends State<AddProject> {
  String? type;
  bool? visibility;
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController logoController = TextEditingController();
  bool isApiCallProcess = false;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      color: Colors.black,
      inAsyncCall: isApiCallProcess,
      opacity: 0.6,
      key: UniqueKey(),
      child: Form(
        key: globalFormKey,
        child: Scaffold(
          appBar: CustomAppBar(),
          body: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Color(0xFFF6F6F6),
              ),
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(context , MaterialPageRoute(builder: (context) => ProfilePage(5)),
                            );
                          },
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.blue),
                          child: Text('Album',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 6.5, left: 6),
                        width: 295,
                        child: TextFormField(
                          controller: logoController,
                          decoration: new InputDecoration(
                            labelText: 'URL image',
                            contentPadding: EdgeInsets.only(bottom:16, left: 8),
                            filled: true,
                            fillColor: Colors.white,
                            isDense: true,
                            border: new OutlineInputBorder(
                                borderSide: new BorderSide(color: Colors.grey)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5,),
                  Text('Project Title:'),
                  SizedBox(height: 5,),
                  TextField(
                    controller: titleController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'title',
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text('Project Type:'),
                  SizedBox(height: 5,),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black54),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                                child: ListTile(
                                  title: const Text("Non-academic",style: TextStyle(
                                      fontSize: 12, fontWeight: FontWeight.bold
                                  )),
                                  leading: Radio(
                                    fillColor: MaterialStateColor.resolveWith(
                                            (states) => Color(0XFFB63728)),
                                    value: "non-academic",
                                    groupValue: type,
                                    onChanged: (value) {
                                      setState(() {
                                        type = value.toString();
                                      });
                                    },
                                  ),
                                )),
                            Expanded(
                                child: ListTile(
                                  title: Text("Academic", style: TextStyle(
                                      fontSize: 12, fontWeight: FontWeight.bold
                                  ),),
                                  leading: Radio(
                                    fillColor: MaterialStateColor.resolveWith(
                                            (states) => Color(0XFFB63728)),
                                    value: "academic",
                                    groupValue: type,
                                    onChanged: (value) {
                                      setState(() {
                                        type = value.toString();
                                      });
                                    },
                                  ),
                                ))
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
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
                  SizedBox(height: 10,),
                  Text('Project description:'),
                  SizedBox(height: 5,),
                  TextField(
                    controller: descController,
                    keyboardType: TextInputType.text,
                    maxLines: 5,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'description',
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text('Visibility:'),
                  SizedBox(height: 5,),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black54),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                                child: ListTile(
                                  title:  Transform.translate(
                                    offset: Offset(-25, 0),
                                    child:  Text("Public",style: TextStyle(
                                        fontSize: 12, fontWeight: FontWeight.bold
                                    )),
                                  ),
                                  leading: Radio(
                                    fillColor: MaterialStateColor.resolveWith(
                                            (states) => Color(0XFFB63728)),
                                    value: true,
                                    groupValue: visibility,
                                    onChanged: (value) {
                                      setState(() {
                                        visibility = true;
                                      });
                                    },
                                  ),
                                  trailing:  Transform.translate(
                                    offset: Offset(-50, 0),
                                    child: Icon(Icons.visibility),
                                  ),
                                )),
                            Expanded(
                                child: ListTile(
                                  title:  Transform.translate(
                                    offset: Offset(-25, 0),
                                    child:  Text("Private",style: TextStyle(
                                        fontSize: 12, fontWeight: FontWeight.bold
                                    )),
                                  ),
                                  leading: Radio(
                                    fillColor: MaterialStateColor.resolveWith(
                                            (states) => Color(0XFFB63728)),
                                    value: false,
                                    groupValue: visibility,
                                    onChanged: (value) {
                                      setState(() {
                                        visibility = false;
                                      });
                                    },
                                  ),
                                  trailing:  Transform.translate(
                                    offset: Offset(-45, 0),
                                    child: Icon(Icons.visibility_off),
                                  ),
                                ))
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.blue
                        ),
                        onPressed: () {
                          APIService().createProject(titleController.text, type!, logoController.text, descController.text, startDateController.text, endDateController.text, visibility!).then((response)
                          {
                            if(response){
                              FormHelper.showSimpleAlertDialog(
                                context,
                                "Success!",
                                "Success create project",
                                "OK",
                                    () {
                                      Navigator.push(context , MaterialPageRoute(builder: (context) => HomePage(2)));
                                },
                              );
                            } else {
                              FormHelper.showSimpleAlertDialog(
                                context,
                                "Error!",
                                "Failed create activity! Please try again",
                                "OK",
                                    () {
                                  Navigator.of(context).pop();
                                },
                              );
                            }
                          }
                          );
                        },
                        child: Text(
                          'Add Project',
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
        ),
      )
    );
  }
}
