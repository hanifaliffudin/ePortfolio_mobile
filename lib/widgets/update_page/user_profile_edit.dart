import 'dart:io';
import 'package:eportfolio/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:image_picker/image_picker.dart';
import '../../config.dart';
import '../custom_appBar.dart';
import 'package:path/path.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;

class EditUserProfile extends StatefulWidget {
  EditUserProfile({Key? key}) : super(key: key);

  @override
  State<EditUserProfile> createState() => _EditUserProfileState();
}

class _EditUserProfileState extends State<EditUserProfile> {

  //File? profilePicture ;
  var filePath;
  final _picker = ImagePicker();
  bool showSpinner = false ;
  var pickedFile;


  Future getImage()async{
    pickedFile = await _picker.pickImage(source: ImageSource.gallery , imageQuality: 80);
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

    var request = new http.MultipartRequest('PUT', uri);
    request.fields['userId'] = userId ;

    var multiport = new http.MultipartFile(
        'profilePicture',
        stream,
        length);

/*    var multiport = await http.MultipartFile.fromBytes('profilePicture', profilePicture,
    filename: ('${filePath}'));*/
    print(pickedFile.path);
    request.files.add(new http.MultipartFile.fromBytes('file', await File.fromUri(Uri.parse(pickedFile.path)).readAsBytes(), contentType: new MediaType('image', 'jpeg')));
    var response = await request.send() ;

    if(response.statusCode == 200){
      print('image uploaded');
      print(filePath);
    }else {
      print('failed');
    }
  }

  bool isApiCallProcess = false;
  bool isImageSelected = false;
  static final GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  TextEditingController nimController = TextEditingController();
  TextEditingController majorController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController dateBirthController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController interestController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  TextEditingController socialMediaController = TextEditingController();
  TextEditingController skillController = TextEditingController();

  var data;

  String? nim;
  String? major;
  String? city;
  String? dateBirth;
  String? gender;
  String? interest;
  String? about;
  File? profilePicture;
  //String? updatedProfilePicture;

  Future<Map<String, dynamic>> getUserData() async{
    data = await APIService.getUserData();
    nim = data['nim'];
    major = data['major'];
    city = data['city'];
    dateBirth = data['dateBirth'];
    gender = data['gender'];
    interest = data['interest'];
    about = data['about'];
    profilePicture = data['profilePicture'];

    nimController.text = nim ?? '';
    majorController.text = major ?? '';
    cityController.text = city ?? '';
    dateBirthController.text = dateBirth ?? '';
    genderController.text = gender ?? '';
    interestController.text = interest ?? '';
    aboutController.text = about ?? '';

    return data;
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
                  GestureDetector(
                    onTap: (){
                      getImage();
                    },
                    child: Container(
                      child :
                        profilePicture == null? Center(child: Text('Pick Image'),) :
                        Container(
                          child: Center(
                            child: Image.file(
                              File(profilePicture!.path).absolute,
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                    ),
                  ),

                  /*profilePicker(
                    isImageSelected,
                    profilePicture ?? "" ,
                        (file) => {
                      setState(
                            () {

                              updatedProfilePicture = file.path;
                              print('hkhjjhkkjhkhlhl${updatedProfilePicture}');

                              isImageSelected = true;
                        },
                      )
                    },
                  ),*/
                  SizedBox(height: 15,),
                  Center(
                    child: GestureDetector(
                      onTap: (){
                        uploadImage();
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
                      /*TextButton(
                        style:
                            TextButton.styleFrom(backgroundColor: Colors.blue),
                        onPressed: () {
                          if (validateAndSave()) {
                            print(productModel!.toJson());

                            setState(() {
                              isApiCallProcess = true;
                            });
                          APIService.updateUserData(
                                  nimController.text,
                                  majorController.text,
                                  cityController.text,
                                  dateBirthController.text,
                                  genderController.text,
                                  interestController.text,
                                  aboutController.text,
                                  profilePicture!,
                                  isImageSelected)
                                  *//*socialMediaController.text,
                                  skillController.text)*//*
                              .then((response) {
                            setState(() {
                              isApiCallProcess = false;
                            });
                            FormHelper.showSimpleAlertDialog(
                              context,
                              "Success!",
                              "Success edit profile",
                              "OK",
                              () {
                                Navigator.pushNamed(context, '/home');
                              },
                            );
                          }
                          );
                        },*/
                      Center(
                        child: FormHelper.submitButton(
                          "Save",
                              () {
                              setState(() {
                                /*print('apakahkosong?${updatedProfilePicture}');*/
                                print('cok');
                                isApiCallProcess = true;
                              });
                              APIService.updateUserData(
                                  nimController.text,
                                  majorController.text,
                                  cityController.text,
                                  dateBirthController.text,
                                  genderController.text,
                                  interestController.text,
                                  aboutController.text,
                                 /* updatedProfilePicture!,*/
                                  isImageSelected)
                                  /*socialMediaController.text,
                                  skillController.text)*/
                                    .then(
                                    (response) {
                                  setState(() {
                                    isApiCallProcess = false;
                                  });

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
                            }
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

  Widget userForm() {
   return FutureBuilder(
      future: getUserData(),
      builder : (context, snapshot){
        if (snapshot.hasData){
          return Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                  child: Text('NIM :')),
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
                  hintText: about ?? '',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text('Major:')),
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
              Align(
                  alignment: Alignment.topLeft,
                  child: Text('City:')),
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
              Align(alignment: Alignment.topLeft,child: Text('Date Birth:')),
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
              Align(alignment: Alignment.topLeft,child: Text('Gender:')),
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
              Align(alignment: Alignment.topLeft,child: Text('Interest:')),
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
              Align(alignment: Alignment.topLeft,child: Text('About Me :')),
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
        } else return CircularProgressIndicator();
      }
    );
  }

  static Widget profilePicker(
    bool isImageSelected,
    String fileName,
    Function onFilePicked,
  ) {
    Future<XFile?> _imageFile;
    ImagePicker _picker = ImagePicker();
   print('ajkhskwd${fileName}');
    return Column(
      children: [
        fileName.isNotEmpty
            ? isImageSelected
                ? Image.file(
                    File(fileName),
                    width: 300,
                    height: 300,
                  )
                : SizedBox(
                    child: Image.network(
                      fileName,
                      width: 200,
                      height: 200,
                      fit: BoxFit.scaleDown,
                    ),
                  )
            : SizedBox(
                child: Image.network(
                  "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png",
                  width: 200,
                  height: 200,
                  fit: BoxFit.scaleDown,
                ),
              ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 35.0,
              width: 35.0,
              child: IconButton(
                padding: const EdgeInsets.all(0),
                icon: const Icon(Icons.image, size: 35.0),
                onPressed: () {
                  _imageFile = _picker.pickImage(source: ImageSource.gallery);
                  _imageFile.then((file) async {
                    onFilePicked(file);
                  });
                },
              ),
            ),
            SizedBox(
              height: 35.0,
              width: 35.0,
              child: IconButton(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                icon: const Icon(Icons.camera, size: 35.0),
                onPressed: () {
                  _imageFile = _picker.pickImage(source: ImageSource.camera);
                  _imageFile.then((file) async {
                    onFilePicked(file);
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
