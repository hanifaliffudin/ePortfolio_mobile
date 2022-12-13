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

    var data = json.decode(response.body);
    jwt = data['jwt'];
    userId = data['userId'];
    if (response.statusCode != 200) {
      print('login failed');
      return false;
    } else {
      print(response.body);
      storage.write(key: 'jwt', value: jwt);
      storage.write(key: 'userId', value: userId.toString());
      getUser();
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

 /* static void getUser() async{
    String? username;
    String? major;
    String? nim;
    String? city;

    final storage = FlutterSecureStorage();
    var userId = await storage.read(key: 'userId');
    await http
        .get(Uri.parse('https://1c77-125-163-127-92.ap.ngrok.io/api/users/$userId'))
        .then((value) {
      var data = json.decode(value.body);
      username = data['username'];
      major = data['major'];
      nim =  data['nim'];
      city = data['city'];

    });*/


 /* List<PostModel> postList =[];

  void postTimeline() async{
    await http
        .get(Uri.parse('https://09f6-180-248-37-185.ap.ngrok.io/api/posts/timeline/all'))
        .then((value) {
      var data = json.decode(value.body);
      for (int i =0 ; i < data.length; i++) {
        print('index=${data[i]}');
        postList.add(PostModel(data[i]['userId'].toString(), data[i]['desc'].toString(), data[i]['updatedAt'.toString()]));
      }
      setState(() {});
    });
  }*/

  //getUser service api
  static Future<String> getUser() async{

    final storage = FlutterSecureStorage();
    var userId = await storage.read(key: 'userId');
    var urlUser = Config.users;
    var url = Uri.parse('$urlUser/$userId');
    var response = await client.post(url);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return data;
    } else {
      return Future.error(Icons.error);
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