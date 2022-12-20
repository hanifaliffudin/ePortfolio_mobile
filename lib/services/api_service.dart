import 'dart:convert';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../config.dart';
import '../models/users_model.dart';
import '../view/home.dart';

class APIService {
  static var client = http.Client();

  //login service api
  static Future<bool> login(String email, String password) async {

    final storage = FlutterSecureStorage();
    String? jwt;
    String? userId;

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
    if (response.statusCode != 200) {
      print('login failed');
      return false;
    } else {
      print(response.body);
      storage.write(key: 'jwt', value: jwt);
      storage.write(key: 'userId', value: userId.toString());
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

  //update user
  static Future<bool> updateUserData(String nim, String major, String city, String dateBirth, String gender, String interest, String about, String socialMedia, String skill) async{
    final storage = FlutterSecureStorage();
    var userId = await storage.read(key: 'userId');
    var urlUser = Config.users;
    var url = Uri.parse('$urlUser/$userId');
    final request = {'userId': userId, 'nim': nim, 'major': major, 'city':city, 'dateBirth': dateBirth, 'gender': gender, 'interest':interest, 'about': about, 'socialMedia': socialMedia, 'skill':skill };
    var response = await client.put(url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request),
    );

    if(response.statusCode != 200){
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

  //get posts service api
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


  //delete post service api
  /*static Future<bool> deletePost() async {
    final storage = FlutterSecureStorage();
    var userId = storage.read(key: 'userId');
    var urlPost = Config.postApi;
    var urlDeletePost = Uri.parse('$urlPost/$postId');

    final request ={'userId': userId};
    final response = await http.delete(
        urlDeletePost,
        body: jsonEncode(request),
        headers: {'Content-Type':'application/json'}
    );


    if(response.statusCode != 200){
      print('delete post failed');
      return false;
    } else{
      return true;
    }
  }
*/

}