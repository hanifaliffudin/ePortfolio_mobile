import 'dart:convert';
import 'package:dio/dio.dart' as Dio;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';
import 'package:eportfolio/models/article_model.dart';
import 'package:eportfolio/models/badges_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:mime_type/mime_type.dart';
import '../config.dart';
import '../models/activity_model.dart';
import '../models/post_model.dart';
import '../models/user_model.dart';

class APIService {
  static var client = http.Client();
  final storage = FlutterSecureStorage();

  //login
  static Future<bool> login(String email, String password) async {
    final storage = FlutterSecureStorage();
    String? jwt;
    String? userId;

    var url = Uri.parse(Config.loginAPI);

    final request = {'email': email, 'password': password};
    var response = await client.post(
      url,
      body: jsonEncode(request),
      headers: {'Content-Type': 'application/json'},
    );

    var data = jsonDecode(response.body);
    jwt = data['jwt'];
    userId = data['userId'];
    if (response.statusCode != 200) {
      print('login failed');
      return false;
    } else {
      print('login success');
      storage.write(key: 'jwt', value: jwt.toString());
      storage.write(key: 'userId', value: userId.toString());
      return true;
    }
  }

  //register
  static Future<bool> register(String username, String email, String password,
      String organization, String role) async {
    var url = Uri.parse(Config.registerAPI);

    final request = {
      'username': username,
      'email': email,
      'password': password,
      'organization': organization,
      'role': role
    };
    var response = await client.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request),
    );

    if (response.statusCode != 200) {
      print('register failed');
      return false;
    } else {
      print('register success');
      return true;
    }
  }

  //fetch User
  Future<UserModel> fetchAnyUser([String? userId]) async {
    var url;
    var urlUser = Config.users;
    if (userId == null) {
      final storage = FlutterSecureStorage();
      var userIdya = await storage.read(key: 'userId');
      url = Uri.parse('$urlUser/$userIdya');
    } else {
      url = Uri.parse('$urlUser/$userId');
    }

    final response = await client.get(url);

    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load user');
    }
  }

  //fetch Id User
  static Future<Map<String, dynamic>> getIdUser(String userIdPosting) async {
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

  //update user
  static Future<bool> updateUserData(
    String nim,
    String major,
    String city,
    String dateBirth,
    String gender,
    String interest,
    String about,
    String linkedin,
    String github,
    String instagram,
    String facebook,
    String twitter,
  ) async {
    final storage = FlutterSecureStorage();
    var userId = await storage.read(key: 'userId');
    var urlUser = Config.users;
    var url = Uri.parse('$urlUser/$userId');
    var request = {
      'userId': userId,
      'nim': nim,
      'major': major,
      'city': city,
      'dateBirth': dateBirth,
      'gender': gender,
      'interest': interest,
      'about': about,
      'socialMedia': {
        'linkedin': linkedin,
        'github' : github,
        'instagram' : instagram,
        'facebook' : facebook,
        'twitter' : twitter,
      }
    };

    var response = await client.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request),
    );

    if (response.statusCode != 200) {
      print('update profile failed');
      return false;
    } else {
      print('update profile success');
      return true;
    }
  }

  //update profilePicture
  Future<bool> uploadImage(XFile profilePicture) async {
    var userId = await storage.read(key: 'userId');
    print('upload started');
    var response = await uploadForm('${Config.users}/${userId}', {
      'userId': '${userId}',
    }, {
      'profilePicture': profilePicture!
    });
    if (response.statusCode != 200) {
      print('tidak berhasil');
      return false;
    } else {
      print("res-1 $response");
      return true;
    }
  }

  Future<Dio.Response> uploadForm(
      String url, Map<String, dynamic> data, Map<String, XFile> files) async {
    Map<String, Dio.MultipartFile> fileMap = {};
    for (MapEntry fileEntry in files.entries) {
      XFile file = fileEntry.value;
      String fileName = basename(file.path);
      String? mimeType = mime(fileName);
      if (mimeType == null) continue;
      String mimee = mimeType.split('/')[0];
      String type = mimeType.split('/')[1];

      fileMap[fileEntry.key] = Dio.MultipartFile(
        file.openRead(),
        await file.length(),
        filename: fileName,
        contentType: MediaType(mimee, type),
      );
    }
    data.addAll(fileMap);
    var formData = Dio.FormData.fromMap(data);
    Dio.Dio dio = Dio.Dio();
    return await dio.put(url,
        data: formData,
        options: Dio.Options(
          contentType: 'multipart/form-data',
        ));
  }

  //get all user
  Future<List<UserModel>> getAllUser({String? query}) async {
    var data = [];
    List<UserModel> results = [];
    var url = Uri.parse('${Config.users}/mobile/all');
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        data = json.decode(response.body);
        results = data.map((e) => UserModel.fromJson(e)).toList();
        if (query != null) {
          results = results
              .where((element) => element.username.toLowerCase()
                  .contains((query.toLowerCase())))
              .toList();
        }
      } else {
        print("fetch error");
      }
    } on Exception catch (e) {
      print('error: $e');
    }
    return results;
  }

  Future<List<UserModel>> getAllFriend() async {
    var url = Uri.parse('${Config.users}/mobile/all');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed.map<UserModel>((json) => UserModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  //-------------------------------POST---------------------------------------------//

  //fetch single post by id
  static Future<Map<String, dynamic>> getSinglePost(String idPost) async {
    var urlPost = Config.post;
    var url = Uri.parse('$urlPost/$idPost');

    var response = await client.get(url);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data;
    } else
      return Future.error(Icons.error);
  }

  //delete post
  static Future<bool> deletePost(String postId) async {
    final storage = FlutterSecureStorage();
    var urlPost = Config.post;
    var url = Uri.parse('$urlPost/$postId');
    var userId = await storage.read(key: 'userId');
    final request = {'userId': userId};
    var response = await client.delete(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(request));

    if (response.statusCode != 200) {
      print('create post failed');
      return false;
    } else {
      print('create post success');
      return true;
    }
  }

  //create post
  static Future<bool> createPost(String desc) async {
    final storage = FlutterSecureStorage();
    var url = Uri.parse(Config.post);
    var userId = await storage.read(key: 'userId');
    final request = {'userId': userId, 'desc': desc};
    final response = await http.post(url,
        body: jsonEncode(request),
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode != 200) {
      print('create post failed');
      return false;
    } else {
      print('create post success');
      return true;
    }
  }

  //fetch all post
  Future<List<PostModel>> fetchPost() async {
    var url = Uri.parse(Config.timelineApi);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed.map<PostModel>((json) => PostModel.fromMap(json)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  //fetch user post
  Future<List<PostModel>> userPost() async {
    final storage = FlutterSecureStorage();
    var url = Config.fetchUserPost;
    var userId = await storage.read(key: 'userId');
    final response = await http.get(Uri.parse('${url}/${userId}'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed.map<PostModel>((json) => PostModel.fromMap(json)).toList();
    } else {
      throw Exception('Failed to load post');
    }
  }

  //fetch friend post
  Future<List<PostModel>> friendPost(String userId) async {
    var urlActivity = Config.fetchUserPost;
    var url = Uri.parse('$urlActivity/$userId');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<PostModel>((json) => PostModel.fromMap(json)).toList();
    } else {
      throw Exception('Failed to load post');
    }
  }

  //-------------------------------POST---------------------------------------------//

  //-------------------------------ARTICLE------------------------------------------//

  //create article
  Future<bool> createArticle(
      String title, String desc, String coverArticle) async {
    final storage = FlutterSecureStorage();
    var url = Uri.parse(Config.article);
    var userId = await storage.read(key: 'userId');
    final request = {
      'userId': userId,
      'title': title,
      'desc': desc,
      'coverArticle': coverArticle
    };
    final response = await http.post(url,
        body: jsonEncode(request),
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode != 200) {
      print('create article failed');
      return false;
    } else {
      print('create article success');
      return true;
    }
  }

  //fetch all article
  Future<List<ArticleModel>> fetchArticle() async {
    var url = Uri.parse(Config.timelineArticleApi);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed
          .map<ArticleModel>((json) => ArticleModel.fromMap(json))
          .toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  //fetch user article
  Future<List<ArticleModel>> userArticle() async {
    final storage = FlutterSecureStorage();
    var url = Config.fetchUserArticle;
    var userId = await storage.read(key: 'userId');
    final response = await http.get(Uri.parse('${url}/${userId}'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed
          .map<ArticleModel>((json) => ArticleModel.fromMap(json))
          .toList();
    } else {
      throw Exception('Failed to load article');
    }
  }

  //fetch friend article
  Future<List<ArticleModel>> friendArticle(String userId) async {
    var url = Config.fetchUserArticle;
    final response = await http.get(Uri.parse('${url}/${userId}'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed
          .map<ArticleModel>((json) => ArticleModel.fromMap(json))
          .toList();
    } else {
      throw Exception('Failed to load article');
    }
  }

  //fetch single article by id
  Future<Map<String, dynamic>> fetchSingleArticle(String id) async {
    var urlUser = Config.article;
    var url = Uri.parse('$urlUser/$id');
    var response = await client.get(url);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data;
    } else {
      return Future.error(Icons.error);
    }
  }

  //update comment
  Future<bool> updateComment(
      String userId, String articleId, var comment) async {
    var urlPost = Config.article;
    var url = Uri.parse('$urlPost/$articleId');
    final request = {'userId': userId, 'comments': comment};
    var response = await client.put(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(request));
    if (response.statusCode != 200) {
      print(response.statusCode);
      return false;
    } else {
      print('update comment success');
      return true;
    }
  }

  //-------------------------------ARTICLE------------------------------------------//

  //-------------------------------ACTIVITY-----------------------------------------//

  //fetch activity by user
  Future<List<ActivityModel>> fetchAnyActivity([String? userId]) async {
    var url;
    var urlActivity = Config.fetchUserActivities;

    if (userId == null) {
      final storage = FlutterSecureStorage();
      var userId = await storage.read(key: 'userId');
      url = Uri.parse('$urlActivity/$userId');
    } else {
      url = Uri.parse('$urlActivity/$userId');
    }

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed
          .map<ActivityModel>((json) => ActivityModel.fromMap(json))
          .toList();
    } else {
      throw Exception('Failed to load article');
    }
  }

  //create activity
  Future<bool> createActivity(String title, String type, String image, String desc,
      String startDate, String endDate) async {
    var url = Uri.parse(Config.activity);
    var userId = await storage.read(key: 'userId');
    final request = {
      'userId': userId,
      'image' : image,
      'title': title,
      'type': type,
      'desc': desc,
      'startDate': startDate,
      'endDate': endDate
    };
    final response = await http.post(url,
        body: jsonEncode(request),
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode != 200) {
      print('create activity failed');
      return false;
    } else {
      print('create activity success');
      return true;
    }
  }



  //-------------------------------ACTIVITY-----------------------------------------//



  //fetch badges by user
  Future<List<BadgesModel>> fetchAnyBadges([String? userId]) async {
    var url;
    var urlActivity = Config.fetchUserBadges;

    if (userId == null) {
      final storage = FlutterSecureStorage();
      var userId = await storage.read(key: 'userId');
      url = Uri.parse('$urlActivity/$userId');
    } else {
      url = Uri.parse('$urlActivity/$userId');
    }

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed
          .map<BadgesModel>((json) => BadgesModel.fromMap(json))
          .toList();
    } else {
      throw Exception('Failed to load article');
    }
  }

  //create badges by user
  Future<bool> createBadge(String imgBadge, String title, String issuer,
      String urlLearn, String earnedDate, String desc) async {
    final storage = FlutterSecureStorage();
    var url = Uri.parse(Config.badges);
    var userId = await storage.read(key: 'userId');
    final request = {
      'userId': userId,
      'imgBadge': imgBadge,
      'title': title,
      'issuer': issuer,
      'url': urlLearn,
      'earnedDate': earnedDate,
      'desc': desc
    };
    final response = await http.post(url,
        body: jsonEncode(request),
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode != 200) {
      print('create badge failed');
      return false;
    } else {
      print('create badge success');
      return true;
    }
  }


//upload album by user


}
