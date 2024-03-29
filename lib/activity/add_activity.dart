import 'package:eportfolio/models/activity_model.dart';
import 'package:eportfolio/view/profile.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import '../services/api_service.dart';
import '../widgets/custom_appBar.dart';

class AddActivity extends StatefulWidget {
  AddActivity({Key? key, this.id}) : super(key: key);
  String? id;

  @override
  State<AddActivity> createState() => _AddActivityState(id ?? '');
}

class _AddActivityState extends State<AddActivity> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController logoController = TextEditingController();
  String? type;
  String? idActivity;
  _AddActivityState(this.idActivity);
  late Future<ActivityModel> futureActivity;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureActivity = APIService().fetchSingleActivity(idActivity);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: FutureBuilder<ActivityModel>(
          future: futureActivity,
          builder: (context, snapshot){
            if(snapshot.hasData){
              titleController.text = snapshot.data!.title ?? '';
              descController.text = snapshot.data!.desc ?? '';
              startDateController.text = snapshot.data!.startDate ?? '';
              endDateController.text = snapshot.data!.endDate ?? '';
              logoController.text = snapshot.data!.image ?? '';
              type = snapshot.data!.type ??'';
              return Column(
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
                        SizedBox(height: 10,),
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
                        SizedBox(height: 5,),
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
                          height: 15,
                        ),
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
                                        title: const Text("Non-Academic"),
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
                                        title: Text("Academic"),
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
                        SizedBox(
                          height: 15,
                        ),
                        TextField(
                          controller: descController,
                          keyboardType: TextInputType.multiline,
                          maxLines: 5,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Activity description',
                            isDense : true,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.blue
                              ),
                              onPressed: () {},
                              child: Text(
                                'Visibility',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(width: 10,),
                            TextButton(
                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.blue
                              ),
                              onPressed: () {
                                APIService().updateActivity(idActivity!, titleController.text, type!, logoController.text, descController.text, startDateController.text, endDateController.text).then((response)
                                {
                                  if(response){
                                    setState(() {
                                    });
                                    Navigator.pushNamed(context, '/home');
                                  } else {
                                    FormHelper.showSimpleAlertDialog(
                                      context,
                                      "Error!",
                                      "Failed update activity! Please try again",
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
                                'Update Activity',
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
              );
            }
            else return Column(
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
                      SizedBox(height: 10,),
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
                      SizedBox(height: 5,),
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
                        height: 15,
                      ),
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
                                      title: const Text("Non-Academic"),
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
                                      title: Text("Academic"),
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
                      SizedBox(
                        height: 15,
                      ),
                      TextField(
                        controller: descController,
                        keyboardType: TextInputType.multiline,
                        maxLines: 5,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Activity description',
                          isDense : true,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.blue
                            ),
                            onPressed: () {},
                            child: Text(
                              'Visibility',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(width: 10,),
                          TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.blue
                            ),
                            onPressed: () {
                              APIService().createActivity(titleController.text, type!, logoController.text, descController.text, startDateController.text, endDateController.text).then((response)
                              {
                                if(response){
                                  setState(() {
                                  });
                                  Navigator.pushNamed(context, '/home');
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
                              'Create Activity',
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
            );
          },
        ),
      ),
    );
  }
}
