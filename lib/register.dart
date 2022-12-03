import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void register() async{
    Map<String, dynamic> map ={
      "username": usernameController.text.toString().trim(),
      "email": emailController.text.toString().trim(),
      "password": passwordController.text.toString().trim()
    };
    var body= json.encode(map);
    var encoding= Encoding.getByName('utf-8');
    const headers = {"Content-Type" : "application/json"};
    try {
      await http
          .post(Uri.parse('http://10.0.2.2:8800/api/auth/register'),
          headers: headers, body: body, encoding: encoding)
          .then((value) {
        Navigator.pushNamed(context, "/");
        print(value.body);
      });
    } catch(e){
      print(e);
    }
  }

  bool isAPIcallProcess = false;
  GlobalKey<FormState> globaFormlKey =GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue,
        body: ProgressHUD(
          child: Form(
            key : globaFormlKey,
            child: _registerUI(context),
          ),
          key: UniqueKey(),
          opacity: 3.0,
          inAsyncCall: isAPIcallProcess,
        ),
      ),
    );
  }
  Widget _registerUI(BuildContext context) {
    return SingleChildScrollView(
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
                    ]
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(100),
                  bottomRight: Radius.circular(100),
                )
            ),
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
            padding: const EdgeInsets.only(
                left: 20,
                bottom: 30,
                top: 50
            ),
            child: Text(
              "Register",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.white
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                TextFormField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    hintText: 'Username',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (String value){},
                  validator: (value){
                    return value!.isEmpty ? 'Please enter username' : null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      prefixIcon: Icon(Icons.people),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (String value){},
                    validator: (value){
                      return value!.isEmpty ? 'Please enter email' : null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      prefixIcon: Icon(Icons.password),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (String value){

                    },
                    validator: (value){
                      return value!.isEmpty ? 'Please enter password' : null;
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20,),
          Center(
            child: FormHelper.submitButton(
              "Register",
                  () {
                //register(emailController.text.toString(), usernameController.text.toString(), passwordController.text.toString());
                    register();
              },
              btnColor: Colors.redAccent,
              borderColor:Colors.white,
              txtColor: Colors.white,
              borderRadius: 10,
            ),
          ),
        ],
      ),
    );
  }
}
