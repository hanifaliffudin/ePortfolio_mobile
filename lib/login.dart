import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  /*  void findUser({required String id}) async{
    //const headers = {"Content-Type" : "application/json"};
    await http.get(Uri.parse('http://10.0.2.2:8800/api/users/${id}'))
    //headers: headers)
    .then((value){
      var data = json.decode(value.body);
      print(data);
      Navigator.pushNamed(context, "/home");
    }
    );
  }*/

  void login() async{
    Map<String, dynamic> map ={
      "email": emailController.text.toString().trim(),
      "password": passwordController.text.toString().trim()
    };
    var body= json.encode(map);
    var encoding= Encoding.getByName('utf-8');
    const headers = {"Content-Type" : "application/json"};
    try {
      await http
          .post(Uri.parse('http://10.0.2.2:8800/api/auth/login'),
          headers: headers, body: body, encoding: encoding)
          .then((value) {
        Navigator.pushNamed(context, "/home");
        print(value.body);
      });
    } catch(e){
      print(e);
    }
  }

  /*void login(String email , password) async {
    try{
      Response response = await post(
          Uri.parse('http://10.0.2.2:8800/api/auth/login'),
          body: {
            'email' : email,
            'password' : password
          }
      );

      if(response.statusCode == 200){

        var data = jsonDecode(response.body.toString());
        print(data['message']);
        print(data['jwt']);
        print(data['userId']);
        print('Login successfully');
        Navigator.pushNamed(context, "/home");

      }else {
        print('failed');
        print(response.statusCode);
        print(response.reasonPhrase);
      }
    }catch(e){
      print(e.toString());
    }
  }*/

  //bool isAPIcallProcess = false;
  //GlobalKey<FormState> globaFormlKey =GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue,
        body: SingleChildScrollView(
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
                  "Login",
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
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (String value){},
                      validator: (value){
                        return value!.isEmpty ? 'Please enter Email' : null;
                      },
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
                        onChanged: (String value){},
                        validator: (value){
                          return value!.isEmpty ? 'Please enter password' : null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10,),
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
                                  decoration : TextDecoration.underline
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = (){
                                  print("Forgot Password");
                                }
                          )
                        ]
                    ) ,
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Center(
                child: FormHelper.submitButton(
                  "Login",
                      () {
                        //findUser(id: '637628e52ae47d8d8eacc2ae');
                        login();
                        //login(emailController.text.toString(), passwordController.text.toString());
    },
                  btnColor: Colors.redAccent,
                  borderColor:Colors.white,
                  txtColor: Colors.white,
                  borderRadius: 10,
                ),
              ),
              SizedBox(height: 20,),
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
              SizedBox(height: 20,),
              Align(
                alignment: Alignment.center,
                child: RichText(
                  text: TextSpan(
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14.0,
                      ),
                      children: <TextSpan>[
                        TextSpan(text: "Don't have an account? ", style: TextStyle(
                          color: Colors.white,
                        )),
                        TextSpan(
                            text: 'Register',
                            style: TextStyle(
                                color: Colors.white,
                                decoration : TextDecoration.underline
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = (){
                                Navigator.pushNamed(context, "/register");
                              }
                        )
                      ]
                  ) ,
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
  //Widget _loginUI(BuildContext context) {
    /*return**/ /*SingleChildScrollView(
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
              "Login",
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
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (String value){},
                  validator: (value){
                    return value!.isEmpty ? 'Please enter Email' : null;
                  },
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
                    onChanged: (String value){},
                    validator: (value){
                      return value!.isEmpty ? 'Please enter password' : null;
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10,),
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
                              decoration : TextDecoration.underline
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = (){
                              print("Forgot Password");
                            }
                      )
                    ]
                ) ,
              ),
            ),
          ),
          SizedBox(height: 20,),
          Center(
            child: FormHelper.submitButton(
              "Login",
                  () {
                getUser('637614ff33cc086b604bc106');
                    //login(emailController.text.toString(), passwordController.text.toString());
                  },
              btnColor: Colors.redAccent,
              borderColor:Colors.white,
              txtColor: Colors.white,
              borderRadius: 10,
            ),
          ),
          SizedBox(height: 20,),
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
          SizedBox(height: 20,),
          Align(
            alignment: Alignment.center,
            child: RichText(
              text: TextSpan(
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14.0,
                  ),
                  children: <TextSpan>[
                    TextSpan(text: "Don't have an account? ", style: TextStyle(
                      color: Colors.white,
                    )),
                    TextSpan(
                        text: 'Register',
                        style: TextStyle(
                            color: Colors.white,
                            decoration : TextDecoration.underline
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = (){
                            Navigator.pushNamed(context, "/register");
                          }
                    )
                  ]
              ) ,
            ),
          ),
        ],
      ),
    );*/
  //}
}
