import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../../config.dart';

class PersonalInformation extends StatefulWidget {
  const PersonalInformation({Key? key}) : super(key: key);
  @override
  State<PersonalInformation> createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {

  final storage = FlutterSecureStorage();
  String? username;
  String? nim;
  String? major;
  String? city;
  //String? dateBirth;

  void getUser() async{
    var userId = await storage.read(key: 'userId');
    var url = Config.users;
    await http
        .get(Uri.parse('$url/$userId'))
        .then((value) {
      var data = jsonDecode(value.body);
      username = data['username'];
      nim = data['nim'];
      major = data['major'];
      city = data['city'];
      setState(() {});
    });
  }

  @override
  void initState(){
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Card(
        color: Colors.grey[200],
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Personal Information',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ],
                      ),
                    ],
                  ),
                  IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz))
                ],
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Align(
                      child: Container(
                          padding: EdgeInsets.only(
                              right: 120, left: 10, top: 10, bottom: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                    text: TextSpan(
                                      style: DefaultTextStyle.of(context).style,
                                      children: [
                                        TextSpan(
                                          text: 'Name : ',
                                          style:
                                          TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                        TextSpan(text: username ?? ''),
                                      ],
                                    )),
                                RichText(
                                    text: TextSpan(
                                      style: DefaultTextStyle.of(context).style,
                                      children: [
                                        TextSpan(
                                            text: 'Student ID : ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        TextSpan(text: nim ?? ''),
                                      ],
                                    )),
                                RichText(
                                    text: TextSpan(
                                      style: DefaultTextStyle.of(context).style,
                                      children: [
                                        TextSpan(
                                            text: 'Major : ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        TextSpan(text: major ?? ''),
                                      ],
                                    )),
                                RichText(
                                    text: TextSpan(
                                      style: DefaultTextStyle.of(context).style,
                                      children: [
                                        TextSpan(
                                            text: 'City : ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        TextSpan(text: city ?? ''),
                                      ],
                                    )),
                                /*RichText(
                                    text: TextSpan(
                                      style: DefaultTextStyle.of(context).style,
                                      children: [
                                        TextSpan(
                                            text: 'Date of Birth : ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        TextSpan(text: dateBirth.toString() ?? ''),
                                      ],
                                    )),*/
                                RichText(
                                    text: TextSpan(
                                      style: DefaultTextStyle.of(context).style,
                                      children: [
                                        TextSpan(
                                            text: 'Gender : ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        TextSpan(text: 'Female'),
                                      ],
                                    )),
                              ],
                            ),
                          )
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
