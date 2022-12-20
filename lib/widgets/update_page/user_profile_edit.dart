import 'package:eportfolio/services/api_service.dart';
import 'package:eportfolio/view/home.dart';
import 'package:eportfolio/view/profile.dart';
import 'package:flutter/material.dart';

import 'package:snippet_coder_utils/FormHelper.dart';

import '../custom_appBar.dart';

class EditUserProfile extends StatelessWidget {
  EditUserProfile({Key? key}) : super(key: key);
  TextEditingController nimController = TextEditingController();
  TextEditingController majorController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController dateBirthController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController interestController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  TextEditingController socialMediaController = TextEditingController();
  TextEditingController skillController = TextEditingController();
  String? jwt;

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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 55,
                          backgroundColor: Colors.grey.shade200,
                          child: CircleAvatar(
                            radius: 50,
                            child: Icon(Icons.person, size: 40),
                          ),
                        ),
                        Positioned(
                          bottom: 1,
                          right: 1,
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(0.1),
                              child: IconButton(color: Colors.black,
                                onPressed: () {  },
                                icon: Icon(Icons.add_a_photo),),
                            ),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  width: 3,
                                  color: Colors.white,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    50,
                                  ),
                                ),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(2, 4),
                                    color: Colors.black.withOpacity(
                                      0.3,
                                    ),
                                    blurRadius: 3,
                                  ),
                                ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text('NIM :'),
                  SizedBox(height: 5,),
                  TextField(
                    controller: nimController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: '195150XXXXXXX',
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text('Major:'),
                  SizedBox(height: 5,),
                  TextField(
                    controller: majorController,
                    keyboardType: TextInputType.multiline,
                    //maxLines: 5,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Informatic Engineer',
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('City:'),
                  SizedBox(height: 5,),
                  TextField(
                    controller: cityController,
                    keyboardType: TextInputType.multiline,
                    //maxLines: 5,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Tuban, East Java',
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Date Birth:'),
                  SizedBox(height: 5,),
                  TextField(
                    controller: dateBirthController,
                    keyboardType: TextInputType.multiline,
                    //maxLines: 5,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: '06 January 2000',
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Gender:'),
                  SizedBox(height: 5,),
                  TextField(
                    controller: genderController,
                    keyboardType: TextInputType.multiline,
                    //maxLines: 5,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Male/Female',
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Interest:'),
                  SizedBox(height: 5,),
                  TextField(
                    controller: interestController,
                    keyboardType: TextInputType.multiline,
                    //maxLines: 5,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Fishing in sea',
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('About Me :'),
                  SizedBox(height: 5,),
                  TextField(
                    controller: aboutController,
                    keyboardType: TextInputType.multiline,
                    //maxLines: 5,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Im a ...',
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Social media :'),
                  SizedBox(height: 5,),
                  TextField(
                    controller: socialMediaController,
                    keyboardType: TextInputType.multiline,
                    //maxLines: 5,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Instagram, etc',
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Skills :'),
                  SizedBox(height: 5,),
                  TextField(
                    controller: skillController,
                    keyboardType: TextInputType.multiline,
                    //maxLines: 5,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Javascript programming, etc',
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Color(0xFFF6F6F6),
              ),
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.blue
                        ),
                        onPressed: () {
                          APIService.updateUserData(nimController.text, majorController.text, cityController.text, dateBirthController.text, genderController.text, interestController.text, aboutController.text, socialMediaController.text, skillController.text).
                          then((response){
                            FormHelper.showSimpleAlertDialog(
                              context,
                              "Success!",
                              "Success edit profile",
                              "OK",
                                  () {
                                    //Navigator.of(context).pop();
                                    //Navigator.pushNamed(context, '/profile');
                                    //
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) => HomePage(jwt??'')));

                                  },
                            );
                          });
                        },
                        child: Text(
                          'Save',
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
