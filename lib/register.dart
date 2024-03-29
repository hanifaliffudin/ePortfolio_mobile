import 'package:eportfolio/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'config.dart';
import 'login.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController organizationController = TextEditingController();
  String? role;
  String? gender;

  void displayDialog(context, title, text) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(title),
            content: Text(text),
          ));


  bool isAPIcallProcess = false;
  GlobalKey<FormState> globaFormlKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue,
        body: ProgressHUD(
          color: Colors.black,
          key: UniqueKey(),
          opacity: 0.6,
          inAsyncCall: isAPIcallProcess,
          child: Form(
            key: globaFormlKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 4,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.white,
                              Colors.white,
                            ]),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(100),
                          bottomRight: Radius.circular(100),
                        )),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Image.asset(
                            "assets/images/LogoFilkom.png",
                            width: 250,
                            fit: BoxFit.contain,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, bottom: 30, top: 50),
                    child: Text(
                      "Register",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: usernameController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                            ),
                            filled: true,
                            prefixIcon: Icon(Icons.supervised_user_circle),
                            fillColor: Colors.white,
                            hintText: 'username',
                          ),
                          onChanged: (String value) {},
                          validator: (value) {
                            return value!.isEmpty ? 'Please enter Username' : null;
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                              ),
                              filled: true,
                              prefixIcon: Icon(Icons.email),
                              fillColor: Colors.white,
                              hintText: 'Email',
                            ),
                            onChanged: (String value) {},
                            validator: (value) {
                              return value!.isEmpty ? 'Please enter Email' : null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: TextFormField(
                            obscureText: true,
                            controller: passwordController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                              ),
                              filled: true,
                              prefixIcon: Icon(Icons.password),
                              fillColor: Colors.white,
                              hintText: 'Password',
                            ),
                            onChanged: (String value) {},
                            validator: (value) {
                              return value!.isEmpty
                                  ? 'Please enter password'
                                  : null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: TextFormField(
                            controller: organizationController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                              ),
                              filled: true,
                              prefixIcon: Icon(Icons.home_repair_service),
                              fillColor: Colors.white,
                              hintText: 'Organization',
                            ),
                            onChanged: (String value) {},
                            validator: (value) {
                              return value!.isEmpty
                                  ? 'Please enter organization'
                                  : null;
                            },
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black54),
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: 5,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Text('Role', style: TextStyle(
                                        fontSize: 16
                                    ),),
                                  ),
                                  Expanded(child: ListTile(
                                    title: const Text("Lecturer"),
                                    leading: Radio(
                                      fillColor: MaterialStateColor.resolveWith((states) => Color(0XFFB63728)),
                                      value: "dosen",
                                      groupValue: role,
                                      onChanged: (value){
                                        setState(() {
                                          role = value.toString();
                                        });
                                      },
                                    ),
                                  )),
                                  Expanded(child: ListTile(
                                    title: const Text("Student"),
                                    leading: Radio(
                                      fillColor: MaterialStateColor.resolveWith((states) => Color(0XFFB63728)),
                                      value: "mahasiswa",
                                      groupValue: role,
                                      onChanged: (value){
                                        setState(() {
                                          role = value.toString();
                                        });
                                      },
                                    ),
                                  ))
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: FormHelper.submitButton(
                      "Register",
                          () {
                        setState(() {
                          isAPIcallProcess = true;
                        });
                        APIService.register(usernameController.text,
                            emailController.text, passwordController.text, organizationController.text, role!)
                            .then((response) {
                          if (response) {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => Login()));
                          } else {
                            FormHelper.showSimpleAlertDialog(
                              context,
                              Config.appName,
                              "Username/Email already used, Please choose another Username/Email",
                              "OK",
                                  () {
                                Navigator.of(context).pop();
                                setState(() {
                                  isAPIcallProcess = false;
                                });
                              },
                            );
                          }
                        });
                      },
                      btnColor: Colors.redAccent,
                      borderColor: Colors.white,
                      txtColor: Colors.white,
                      borderRadius: 10,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}
