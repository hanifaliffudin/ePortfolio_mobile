import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;


import '../config.dart';
import '../models/post_model.dart';

class APIService {
  static var client = http.Client();

  //login service api
  static Future<bool> login(String email, String password) async {

    final storage = FlutterSecureStorage();
    String? jwt;
    String? userId;
    String? nim;

    var url = Uri.parse(
      Config.loginAPI
    );

    final request = {'email': email, 'password': password};
    var response = await client.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request),
    );

    var data = jsonDecode(response.body);
    jwt = data['jwt'];
    userId = data['userId'];
    nim = data['nim'];
    if (response.statusCode != 200) {
      print('login failed');
      return false;
    } else {
      print(response.body);
      storage.write(key: 'jwt', value: jwt);
      storage.write(key: 'userId', value: userId.toString());
      storage.write(key: 'nim', value: nim.toString());
      getIdUserPosting(userId.toString());
      return true;
    }
  }

  //register service api
  static Future<bool> register(String username, String email, String password) async{
    var url = Uri.parse(
        Config.registerAPI
    );

    final request = {'username': username, 'email': email, 'password':password};
    var response = await client.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request),
    );

    if(response.statusCode != 200){
      print('register failed');
      return false;
    } else {
      print('register success');
      return true;
    }
  }

  //getIdUserPosting service api
  static Future<Map<String, dynamic>> getIdUserPosting(String userIdPosting) async{

    var urlUser = Config.users;
    var url = Uri.parse('$urlUser/$userIdPosting');

    var response = await client.get(url);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data;
    } else {
      return Future.error(Icons.error);
    }
}


  //getUser
  static Future<Map<String, dynamic>> getUserData() async{
    final storage = FlutterSecureStorage();
    var userId = await storage.read(key: 'userId');
    var urlUser = Config.users;
    var url = Uri.parse('$urlUser/$userId');
    var response = await client.get(url);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data;
    } else {
      return Future.error(Icons.error);
    }
  }

  //Update user
  static Future<bool> updateUserData(String nim, String major, String city, String dateBirth, String gender, String interest, String about/*, String socialMedia, String skill*/,/*String profilePicture,*/ bool isFileSelected) async{

    final storage = FlutterSecureStorage();
    var userId = await storage.read(key: 'userId');
    var urlUser = Config.users;
    var url = Uri.parse('$urlUser/$userId');

    var newrequest = http.MultipartRequest('PUT', url);
    newrequest.fields['userId'] = userId;
    newrequest.fields['nim'] = nim;
    newrequest.fields['major'] = major;
    newrequest.fields['city'] = city;
    newrequest.fields['dateBirth'] = dateBirth;
    newrequest.fields['gender'] = gender;
    newrequest.fields['interest'] = interest;
    newrequest.fields['about'] = about;

    //var filePath = File(fileBits, '/storage/images/$profilePicture');

   /* if (profilePicture != null && isFileSelected) {
      http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
        'profilePicture',
        profilePicture,
      );
      newrequest.files.add(multipartFile);
      print('inisjdksah $multipartFile');
    }*/


    var newresponse = await newrequest.send();

    /*final request = {'userId': userId, 'nim': nim, 'major': major, 'city':city, 'dateBirth': dateBirth, 'gender': gender, 'interest':interest, 'about': about, *//*'socialMedia': socialMedia, 'skill':skill*//* };
    var response = await client.put(url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request),
    );*/

    if(newresponse.statusCode != 200){
      print('update profile failed');
      return false;
    } else {
      print('update profile success');
      return true;
    }
  }


  //delete post
  static Future<bool> deletePost(String postId) async{
    final storage = FlutterSecureStorage();
    var urlPost = Config.postApi;
    var url = Uri.parse('$urlPost/$postId');
    var userId = await storage.read(key: 'userId');
    final request = {'userId': userId};
    var response = await client.delete(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request)
    );

    if(response.statusCode != 200){
      print('create post failed');
      return false;
    } else {
      print('create post success');
      return true;
    }
  }

  //create posts service api
  static Future<bool> createPost(String desc) async{
    final storage = FlutterSecureStorage();
    var url = Uri.parse(Config.postApi);
    var userId = await storage.read(key: 'userId');
    final request = {'userId': userId, 'desc': desc};
    final response = await http.post(
        url,
        body: jsonEncode(request),
        headers: {'Content-Type':'application/json'}
    );

    if(response.statusCode != 200){
      print('create post failed');
      return false;
    } else {
      print('create post success');
      return true;
    }
  }




}