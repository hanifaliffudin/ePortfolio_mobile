import 'dart:io';
import 'dart:async';
import 'package:eportfolio/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:image_picker/image_picker.dart';
import '../../config.dart';
import '../../models/user_model.dart';
import '../custom_appBar.dart';

class EditUserProfile extends StatefulWidget {
  EditUserProfile({Key? key}) : super(key: key);

  @override
  State<EditUserProfile> createState() => _EditUserProfileState();
}

class _EditUserProfileState extends State<EditUserProfile> {
  XFile? profilePicture;
  TextEditingController nimController = TextEditingController();
  TextEditingController majorController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController dateBirthController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController interestController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  TextEditingController socialMediaController = TextEditingController();
  TextEditingController skillController = TextEditingController();

  late Future<UserModel> futureUser;

  @override
  void initState() {
    super.initState();
    futureUser = APIService().fetchAnyUser();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel>(
      future: futureUser,
      builder: (context, snapshot){
        if(snapshot.hasData){
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
                                child: profilePicture != null
                                    ? CircleAvatar(
                                    radius: 100,
                                    backgroundImage:
                                    FileImage(File(profilePicture!.path)))
                                    : CircleAvatar(
                                  radius: 100,
                                    backgroundImage:
                                    NetworkImage(
                                      (snapshot.data!.profilePicture ==
                                          null ||
                                          snapshot.data!.profilePicture ==
                                              "")
                                          ? "https://ceblog.s3.amazonaws.com/wp-content/uploads/2018/08/20142340/best-homepage-9.png"
                                          : '${Config.apiURL}/${snapshot.data!.profilePicture.toString()}',
                                    ),
                                ),
                              ),
                              Positioned(
                                bottom: 1,
                                right: 1,
                                child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        _getFromGallery();
                                      },
                                      child: Icon(Icons.add_a_photo,
                                          color: Colors.black),
                                    ),
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
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: TextButton(
                              style: ButtonStyle(
                                backgroundColor:
                                MaterialStatePropertyAll<Color>(Colors.blue),
                                shape:
                                MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                APIService().uploadImage(profilePicture!).then(
                                      (response) {
                                    if (response) {
                                      FormHelper.showSimpleAlertDialog(
                                        context,
                                        Config.appName,
                                        "Update photo success",
                                        "OK",
                                            () {
                                              Navigator.pushNamedAndRemoveUntil(
                                                context,
                                                '/profile',
                                                    (route) => false,
                                              );
                                        },
                                      );
                                    } else {
                                      FormHelper.showSimpleAlertDialog(
                                        context,
                                        Config.appName,
                                        "Error occur",
                                        "OK",
                                            () {
                                          Navigator.of(context).pop();
                                        },
                                      );
                                    }
                                  },
                                );;
                              },
                              child: Text('Update', style: TextStyle(color: Colors.white),)),
                        ),
                        userForm()
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
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
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Center(
                              child: FormHelper.submitButton("Save", () {
                                APIService.updateUserData(
                                  nimController.text,
                                  majorController.text,
                                  cityController.text,
                                  dateBirthController.text,
                                  genderController.text,
                                  interestController.text,
                                  aboutController.text,
                                ).then(
                                      (response) {
                                    if (response) {
                                      Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        '/profile',
                                            (route) => false,
                                      );
                                    } else {
                                      FormHelper.showSimpleAlertDialog(
                                        context,
                                        Config.appName,
                                        "Error occur",
                                        "OK",
                                            () {
                                          Navigator.of(context).pop();
                                        },
                                      );
                                    }
                                  },
                                );
                              }),
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
        } else return CircularProgressIndicator();
      }
    );
  }

  Widget userForm() {
    return FutureBuilder<UserModel>(
        future: futureUser,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            nimController.text = snapshot.data!.nim ?? '';
            majorController.text = snapshot.data!.major ?? '';
            cityController.text = snapshot.data!.city ?? '';
            dateBirthController.text = snapshot.data!.dateBirth ?? '';
            genderController.text = snapshot.data!.gender ?? '';
            interestController.text = snapshot.data!.interest ?? '';
            aboutController.text = snapshot.data!.about ?? '';
            return Column(
              children: [
                Align(alignment: Alignment.topLeft, child: Text('NIM :')),
                SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: nimController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: '175150xxxxxxxx',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Align(alignment: Alignment.topLeft, child: Text('Major:')),
                SizedBox(
                  height: 5,
                ),
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
                Align(alignment: Alignment.topLeft, child: Text('City:')),
                SizedBox(
                  height: 5,
                ),
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
                Align(alignment: Alignment.topLeft, child: Text('Date Birth:')),
                SizedBox(
                  height: 5,
                ),
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
                Align(alignment: Alignment.topLeft, child: Text('Gender:')),
                SizedBox(
                  height: 5,
                ),
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
                Align(alignment: Alignment.topLeft, child: Text('Interest:')),
                SizedBox(
                  height: 5,
                ),
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
                Align(alignment: Alignment.topLeft, child: Text('About Me :')),
                SizedBox(
                  height: 5,
                ),
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
                /*Text('Social media :'),
          SizedBox(
            height: 5,
          ),
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
          ),*/
                /*Text('Skills :'),
          SizedBox(
            height: 5,
          ),
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
          ),*/
              ],
            );
          } else
            return CircularProgressIndicator();
        });
  }

  _getFromGallery() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        profilePicture = XFile(pickedFile.path);
      });
    }
  }
}
