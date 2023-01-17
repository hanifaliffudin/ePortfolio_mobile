import 'package:eportfolio/register.dart';
import 'package:eportfolio/services/api_service.dart';
import 'package:eportfolio/view/home.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

import 'config.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isApiCallProcess = false;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? jwt;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.blue,
          body: ProgressHUD(
            color: Colors.black,
            inAsyncCall: isApiCallProcess,
            opacity: 0.6,
            key: UniqueKey(),
            child: Form(
              key: globalFormKey,
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
                        "Login",
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
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 25, top: 10),
                        child: RichText(
                          text: TextSpan(
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 14.0,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'Forgot Password ?',
                                    style: TextStyle(
                                        color: Colors.white,
                                        decoration: TextDecoration.underline),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        print("Forgot Password");
                                      })
                              ]),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: FormHelper.submitButton(
                        "Login",
                        () {
                          setState(() {
                            isApiCallProcess = true;
                          });
                          APIService.login(
                                  emailController.text, passwordController.text)
                              .then((response) {
                            if (response) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage(0)));
                            } else {
                              FormHelper.showSimpleAlertDialog(
                                context,
                                Config.appName,
                                "Invalid Username/Password !!",
                                "OK",
                                () {
                                  Navigator.of(context).pop();
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
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Text(
                        "OR",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: RichText(
                        text: TextSpan(
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14.0,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                  text: "Don't have an account? ",
                                  style: TextStyle(
                                    color: Colors.white,
                                  )),
                              TextSpan(
                                  text: 'Register',
                                  style: TextStyle(
                                      color: Colors.white,
                                      decoration: TextDecoration.underline),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Register()));
                                    })
                            ]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
