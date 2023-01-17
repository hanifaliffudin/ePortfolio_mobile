import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

import '../services/api_service.dart';
import '../widgets/custom_appBar.dart';
class AddBadges extends StatefulWidget {
  const AddBadges({Key? key}) : super(key: key);

  @override
  State<AddBadges> createState() => _AddBadgesState();
}

class _AddBadgesState extends State<AddBadges> {
  TextEditingController titleController = TextEditingController();
  TextEditingController imgBadgeController = TextEditingController();
  TextEditingController issuerController = TextEditingController();
  TextEditingController urlController = TextEditingController();
  TextEditingController earnedDateController = TextEditingController();
  TextEditingController descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width :250,
                        child: TextField(
                          controller: imgBadgeController,
                          keyboardType: TextInputType.text,
                          style: TextStyle(height: 0.5,),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'Image Url',
                            isDense: true,
                          ),
                        ),
                      ),
                      SizedBox(height: 5,),
                      TextButton( style: TextButton.styleFrom(
                          backgroundColor: Colors.blue
                      ),onPressed: (){}, child: Text(
                        'Go to Album', style: TextStyle(
                        color: Colors.white
                      ),
                      ))
                    ],
                  ),
                  SizedBox(height: 15,),
                  TextField(
                    controller: titleController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Badges title',
                      isDense: true,
                    ),
                  ),
                  SizedBox(height: 15,),
                  TextField(
                    controller: issuerController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Issuer',
                      isDense: true,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: urlController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Url Learn More',
                      isDense: true,
                    ),
                  ),
                  SizedBox(height: 5,),
                  Align(
                    alignment: Alignment.topLeft,
                    child: SizedBox(
                      width: 125,
                      child: TextField(
                        controller: earnedDateController,
                        decoration: InputDecoration(
                            icon: Icon(Icons.calendar_today), //icon of text field
                            labelText: "Earn Date" //label text of field
                        ),
                        readOnly: true,
                        onTap: () async{
                          DateTime? pickedDate = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(2101));
                          if(pickedDate != null) {
                            String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                            setState(() {
                              earnedDateController.text = formattedDate;
                            });
                          } else {
                            print("Date is not selected");
                          }
                        },
                      ),
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
                      isDense :true
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
                           APIService().createBadge(imgBadgeController.text, titleController.text, issuerController.text, urlController.text, earnedDateController.text, descController.text)
                              .then((response) {
                            if (response) {
                              Navigator.pushNamed(context, '/profile');
                            } else {
                              FormHelper.showSimpleAlertDialog(
                                context,
                                "Error!",
                                "Failed create article! Please try again",
                                "OK",
                                    () {
                                  Navigator.of(context).pop();
                                },
                              );
                            }
                          });
                        },
                        child: Text(
                          'Add badges',
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
