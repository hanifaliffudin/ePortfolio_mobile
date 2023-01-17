import 'dart:io';
import 'dart:async';
import 'package:eportfolio/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import '../../config.dart';
import '../../models/user_model.dart';
import '../custom_appBar.dart';

class EditUserProfile extends StatefulWidget {
  const EditUserProfile({Key? key}) : super(key: key);

  @override
  State<EditUserProfile> createState() => _EditUserProfileState();
}

class _EditUserProfileState extends State<EditUserProfile> {
  XFile? profilePicture;
  TextEditingController nimController = TextEditingController();
  TextEditingController majorController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController dateBirthController = TextEditingController();
  String? genderController;
  TextEditingController interestController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  TextEditingController socialMediaController = TextEditingController();
  TextEditingController skillController = TextEditingController();
  TextEditingController linkedin = TextEditingController();
  TextEditingController github = TextEditingController();
  TextEditingController instagram = TextEditingController();
  TextEditingController facebook = TextEditingController();
  TextEditingController twitter = TextEditingController();
  bool isApiCallProcess = false;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
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
        builder: (context, snapshot) {
          if (snapshot.hasData) {
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
                                ProgressHUD(
                                  color: Colors.black,
                                  inAsyncCall: isApiCallProcess,
                                  opacity: 0.6,
                                  key: UniqueKey(),
                                  child: Form(
                                    key: globalFormKey,
                                    child: CircleAvatar(
                                      radius: 55,
                                      backgroundColor: Colors.grey.shade200,
                                      child: profilePicture != null
                                          ? CircleAvatar(
                                              radius: 100,
                                              backgroundImage: FileImage(
                                                  File(profilePicture!.path)))
                                          : CircleAvatar(
                                              radius: 100,
                                              backgroundImage: NetworkImage(
                                                (snapshot.data!.profilePicture ==
                                                        "")
                                                    ? "https://ceblog.s3.amazonaws.com/wp-content/uploads/2018/08/20142340/best-homepage-9.png"
                                                    : '${Config.apiURL}/${snapshot.data!.profilePicture.toString()}',
                                              ),
                                            ),
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
                                    dateBirthController!.text,
                                    genderController!,
                                    interestController.text,
                                    aboutController.text,
                                    linkedin.text,
                                    github.text,
                                    instagram.text,
                                    facebook.text,
                                    twitter.text,
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
          } else
            return CircularProgressIndicator();
        });
  }

  Widget userForm() {
    return FutureBuilder<UserModel>(
        future: futureUser,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            nimController.text = snapshot.data!.nim ?? '';
            majorController.text = snapshot.data!.major ?? '';
            genderController = snapshot.data!.gender.toString();
            cityController.text = snapshot.data!.city ?? '';
            dateBirthController.text = snapshot.data!.dateBirth;
            interestController.text = snapshot.data!.interest ?? '';
            aboutController.text = snapshot.data!.about;
            linkedin.text = snapshot.data!.socialMedia?.linkedin ?? '';
            github.text = snapshot.data!.socialMedia?.github ?? '';
            instagram.text = snapshot.data!.socialMedia?.instagram ?? '';
            facebook.text = snapshot.data!.socialMedia?.facebook ?? '';
            twitter.text = snapshot.data!.socialMedia?.twitter ?? '';
            return Column(
              children: [
                const Align(alignment: Alignment.topLeft, child: Text('NIM :')),
                const SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: nimController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: '175150xxxxxxxx',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Align(
                    alignment: Alignment.topLeft, child: Text('Major:')),
                const SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: majorController,
                  keyboardType: TextInputType.multiline,
                  //maxLines: 5,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Informatic Engineer',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Align(alignment: Alignment.topLeft, child: Text('City:')),
                const SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: cityController,
                  keyboardType: TextInputType.multiline,
                  //maxLines: 5,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Tuban, East Java',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 300,
                      child: TextField(
                        controller: dateBirthController,
                        decoration: InputDecoration(
                            icon: GestureDetector(
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2101));
                                  if (pickedDate != null) {
                                    String formattedDate =
                                        DateFormat('yyyy-MM-dd')
                                            .format(pickedDate);
                                    dateBirthController.text = formattedDate;
                                  } else {
                                    print("Date is not selected");
                                  }
                                },
                                child: Icon(Icons.calendar_today, size: 50.0,)),
                            //icon of text field
                            labelText: "Birth date" //label text of field
                            ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Align(
                    alignment: Alignment.topLeft, child: Text('Gender:')),
                const SizedBox(
                  height: 5,
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
                            title: const Text("Male"),
                            leading: Radio(
                              fillColor: MaterialStateColor.resolveWith(
                                  (states) => Color(0XFFB63728)),
                              value: "male",
                              groupValue: genderController,
                              onChanged: (value) {
                                setState(() {
                                  genderController = value.toString();
                                });
                              },
                            ),
                          )),
                          Expanded(
                              child: ListTile(
                            title: const Text("Female"),
                            leading: Radio(
                              fillColor: MaterialStateColor.resolveWith(
                                  (states) => Color(0XFFB63728)),
                              value: "female",
                              groupValue: genderController,
                              onChanged: (value) {
                                setState(() {
                                  genderController = value.toString();
                                });
                              },
                            ),
                          ))
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Align(
                    alignment: Alignment.topLeft, child: Text('Interest:')),
                const SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: interestController,
                  keyboardType: TextInputType.multiline,
                  //maxLines: 5,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Fishing in sea',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Align(
                    alignment: Alignment.topLeft, child: Text('About Me :')),
                const SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: aboutController,
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Im a ...',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Align(
                    alignment: Alignment.topLeft,
                    child: Text('Social media :')),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  //linkedin
                  child: Container(
                    padding:
                        EdgeInsets.only(left: 5, right: 5, top: 15, bottom: 15),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              CircleAvatar(
                                child: Image.asset(
                                  "assets/images/linkdin.png",
                                ),
                                radius: 25,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Container(
                                  color: Colors.transparent,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      TextField(
                                        controller: linkedin,
                                        style: TextStyle(fontSize: 15),
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          filled: true,
                                          fillColor: Colors.white,
                                          labelText: 'LinkedIn',
                                          isDense: true, // Added this
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  //github
                  child: Container(
                    padding:
                        EdgeInsets.only(left: 5, right: 5, top: 15, bottom: 15),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              CircleAvatar(
                                child: Image.asset(
                                  "assets/images/github.png",
                                ),
                                radius: 25,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Container(
                                  color: Colors.transparent,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      TextField(
                                        controller: github,
                                        style: TextStyle(fontSize: 15),
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          filled: true,
                                          fillColor: Colors.white,
                                          labelText: 'Github',
                                          isDense: true, // Added this
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  //instagram
                  child: Container(
                    padding:
                        EdgeInsets.only(left: 5, right: 5, top: 15, bottom: 15),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              CircleAvatar(
                                child: Image.asset(
                                  "assets/images/ig.png",
                                ),
                                radius: 25,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Container(
                                  color: Colors.transparent,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      TextField(
                                        controller: instagram,
                                        style: TextStyle(fontSize: 15),
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          filled: true,
                                          fillColor: Colors.white,
                                          labelText: 'Instagram',
                                          isDense: true, // Added this
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  //instagram
                  child: Container(
                    padding:
                        EdgeInsets.only(left: 5, right: 5, top: 15, bottom: 15),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              CircleAvatar(
                                child: Image.asset(
                                  "assets/images/fb.png",
                                ),
                                radius: 25,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Container(
                                  color: Colors.transparent,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      TextField(
                                        controller: facebook,
                                        style: TextStyle(fontSize: 15),
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          filled: true,
                                          fillColor: Colors.white,
                                          labelText: 'Facebook',
                                          isDense: true, // Added this
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  //twitter
                  child: Container(
                    padding:
                        EdgeInsets.only(left: 5, right: 5, top: 15, bottom: 15),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              CircleAvatar(
                                child: Image.asset(
                                  "assets/images/twitter.png",
                                ),
                                radius: 25,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Container(
                                  color: Colors.transparent,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      TextField(
                                        controller: twitter,
                                        style: TextStyle(fontSize: 15),
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          filled: true,
                                          fillColor: Colors.white,
                                          labelText: 'Twitter',
                                          isDense: true, // Added this
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Align(alignment: Alignment.topLeft, child: Text('Skills :')),
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
                ),
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
    setState(() {
      isApiCallProcess = true;
    });
    APIService().uploadImage(profilePicture!).then(
          (response) {
        if (response) {
          print('success');
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
  }
}
