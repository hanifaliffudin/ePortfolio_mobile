import 'dart:ui';

import 'package:dio/dio.dart' as Dio;
import 'package:http/http.dart' as http;
/*import 'package:dio/dio.dart';*/
import 'dart:io';
import 'dart:async';
import 'package:path/path.dart';
import 'package:eportfolio/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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

  //-----------------------------------------USING DIO----------------------------------//

  XFile? imageFile;

  Future _uploadImage() async {
    final storage = FlutterSecureStorage();
    var userId = await storage.read(key: 'userId');
    /*var selectedImage = File(imageFile!.path);*/

    print('upload started');

    try {
      var response = await sendForm('${Config.users}/${userId}',
          {'userId': '${userId}'}, {'profilePicture': imageFile!});

      if(response.statusCode != 200){
        print('tidak berhasil');
      } else {
        print("res-1 $response");
      }

    } catch ( err) {
      print(err);
    }
    setState(() {
      imageFile = imageFile;
    });
  }

  Future<Dio.Response> sendForm(
      String url, Map<String, dynamic> data, Map<String, XFile> files) async {
    Map<String, Dio.MultipartFile> fileMap = {};
    for (MapEntry fileEntry in files.entries) {
      XFile file = fileEntry.value;
      String fileName = basename(file.path);
      fileMap[fileEntry.key] = Dio.MultipartFile(
          file.openRead(), await file.length(),
          filename: fileName);
    }
    data.addAll(fileMap);
    var formData = Dio.FormData.fromMap(data);
    Dio.Dio dio = new Dio.Dio();
    return await dio.put(url,
        data: formData,
        options: Dio.Options(contentType: 'multipart/form-data',
       ));
  }

  //-----------------------------------------USING DIO----------------------------------//

  //-----------------------------------------USING HTTP----------------------------------//

  /*File? profilePicture ;
  var filePath;
  bool showSpinner = false ;
  var pickedFile;

  Future getImage()async{
    pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery , imageQuality: 80);
    if(pickedFile!= null ){
      profilePicture =  File(pickedFile.path);
      filePath = basename(pickedFile.path);
      setState(() {
      });
    }else {
      print('no image selected');
    }
  }

  Future<void> uploadImage()async{

    var stream  = new http.ByteStream(profilePicture!.openRead());
    stream.cast();

    var length = await profilePicture!.length();

    final storage = FlutterSecureStorage();
    var userId = await storage.read(key: 'userId');
    var urlUser = Config.users;
    var uri = Uri.parse('$urlUser/$userId');

    var request = new http.MultipartRequest('POST', uri);
    request.fields['userId'] = userId ;

    var multiport = new http.MultipartFile(
        'profilePicture',
        stream,
        length);

    print(pickedFile.path);
    request.files.add(multiport);
    for (var e in request.headers.entries) {
      print('${e.key} = ${e.value}');
    }

    var response = await request.send() ;
    print("RESSSP");
    print(await response.stream.bytesToString());

    if(response.statusCode == 200){
      print('image uploaded');
      print(filePath);
    }else {
      print('failed');
    }
  }*/
  //-----------------------------------------USING HTTP----------------------------------//

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
    futureUser = APIService().fetchUser();
  }

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
                  //-------------------------------------------------------------------------------//

                  //--------------------------------------------------------------------------------//
                  GestureDetector(
                    onTap: () {
                      _getFromGallery();
                    },
                    child: Container(
                        child: imageFile == null
                            ? Center(
                                child: Text('Pick Image'),
                              )
                            : Container(
                                child: Center(
                                  child: Image.file(
                                    File(imageFile!.path).absolute,
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )),
                  ),

                  SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        _uploadImage();
                      },
                      child: Container(
                        height: 50,
                        color: Colors.green,
                        child: Text('upload'),
                      ),
                    ),
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
                            /*profilePicture!,*/
                            /*isImageSelected*/
                          )
                              /*socialMediaController.text,
                                    skillController.text)*/
                              .then(
                            (response) {
                              /* setState(() {
                                    isApiCallProcess = false;
                                  });*/

                              if (response) {
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  '/home',
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
        imageFile = XFile(pickedFile.path);
      });
    }
  }

}
