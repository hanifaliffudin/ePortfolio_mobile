import 'dart:convert';

import 'package:dio/dio.dart' as Dio;
import 'package:eportfolio/models/project_model.dart';
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
import '../models/album_model.dart';
import '../models/post_model.dart';
import '../models/user_model.dart';
import '../project/notification_model.dart';

class APIService {
  static var client = http.Client();
  final storage = FlutterSecureStorage();

  Future fetchUserId() async{
    final storage = FlutterSecureStorage();
    String? userId = await storage.read(key: 'userId');
    return userId;
  }

  //login
  static Future<bool> login(String email, String password) async {
    final storage = FlutterSecureStorage();
    String? jwt;
    String? userId;
    String? major;
    String? organization;

    var url = Uri.parse(Config.loginAPI);

    final request = {'email': email, 'password': password};
    var response = await client.post(
      url,
      body: jsonEncode(request),
      headers: {'Content-Type': 'application/json'},
    );

    var data = jsonDecode(response.body);
    if (response.statusCode != 200) {
      print('login failed');
      return false;
    } else {
      print('login success');
      jwt = data['jwt'];
      userId = data['userId'];
      storage.write(key: 'jwt', value: jwt.toString());
      storage.write(key: 'userId', value: userId.toString());
      storage.write(key: 'major', value: major.toString());
      storage.write(key: 'organization', value: organization.toString());
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
    var userIdya = await storage.read(key: 'userId');
    if (userId == null) {
      final storage = FlutterSecureStorage();
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

  //fetcg project
  static Future<Map<String, dynamic>> getOneProject(String idProject) async {
    var urlUser = Config.project;
    var url = Uri.parse('$urlUser/$idProject');
    var response = await client.get(url);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data;
    } else {
      return Future.error(Icons.error);
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
    [String? nim,
    String? major,
    String? city,
    String? dateBirth,
    String? gender,
    String? organization,
    String? interest,
    String? about,
    String? linkedin,
    String? github,
    String? instagram,
    String? facebook,
    String? twitter,
      String? academicField]
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
      'organization' : organization,
      'interest': interest,
      'about': about,
      'academicField' : academicField,
      'socialMedia': {
        'linkedin': linkedin,
        'github': github,
        'instagram': instagram,
        'facebook': facebook,
        'twitter': twitter,
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
      'profilePicture': profilePicture
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

  //search user
  Future<Object> searchUser({String? query}) async {
    var userId = await storage.read(key: 'userId');
    List<dynamic> data = [];
    var url = Uri.parse('${Config.users}/search/$userId/$query');
    var response = await client.get(url);
    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      return data;
    } else {
      return Future.error(Icons.error);
    }
  }

  //suggested user
  Future<Object> sugesstedUser(String major, String organization) async {
    var userId = await storage.read(key: 'userId');
    List<dynamic> data = [];
    var url = Uri.parse('${Config.users}/suggest/$major/$organization/$userId');
    var response = await client.get(url);
    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      return data;
    } else {
      return Future.error(Icons.error);
    }
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
              .where((element) => element.username
                  .toLowerCase()
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

  Future<bool> follow(String following) async {
    final storage = FlutterSecureStorage();
    var urlUser = Config.users;
    var url = Uri.parse('$urlUser/follow/$following');
    var userId = await storage.read(key: 'userId');
    final request = {'userIdFollowing': userId};
    var response = await client.put(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(request));

    if (response.statusCode != 200) {
      print('follow user failed');
      return false;
    } else {
      print('follow user success');
      return true;
    }
  }

  Future<bool> unfollow(String following) async {
    final storage = FlutterSecureStorage();
    var urlUser = Config.users;
    var url = Uri.parse('$urlUser/unfollow/$following');
    var userId = await storage.read(key: 'userId');
    final request = {'userIdUnfollowing': userId};
    var response = await client.put(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(request));

    if (response.statusCode != 200) {
      print('unfollow user failed');
      return false;
    } else {
      print('unfollow user success');
      return true;
    }
  }

  //-------------------------------POST---------------------------------------------//

  //fetch single post by id
  Future<PostModel> fetchSinglePost([String? idPost]) async {
    var urlPost = Config.post;
    var url = Uri.parse('$urlPost/$idPost');
    var response = await client.get(url);
    if (response.statusCode == 200) {
      var data = PostModel.fromMap(jsonDecode(response.body));
      return data;
    } else
      return Future.error(Icons.error);
  }

  //update post
  Future<bool> updatePost(String postId, String desc, bool isPublic) async {
    var urlPost = Config.post;
    var userId = await storage.read(key: 'userId');
    var url = Uri.parse('$urlPost/$postId');
    final req = {'userId': userId, 'desc': desc, 'isPublic' : isPublic};
    final res = await http.put(url,
        body: jsonEncode(req),
        headers: {'Content-Type': 'application/json'});
    if(res.statusCode!=200){
      print('Update post failed');
      return false;
    } else{
      print('update article success');
      return true;
    }
  }

  //delete post
  Future<bool> deletePost(String postId) async {
    var urlPost = Config.post;
    var url = Uri.parse('$urlPost/$postId');
    var userId = await storage.read(key: 'userId');
    final request = {'userId': userId};
    var response = await client.delete(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(request));

    if (response.statusCode != 200) {
      print('delete post failed');
      return false;
    } else {
      print('delete post success');
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

  //fetch post from followe friend
  Future<List<PostModel>> fetchPost() async {
    var urlPost = Config.timelineApi;
    var userId = await storage.read(key: 'userId');
    var url = Uri.parse('$urlPost/$userId');
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
    var urlPost = Config.fetchUserPost;
    var url = Uri.parse('$urlPost/$userId');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<PostModel>((json) => PostModel.fromMap(json)).toList();
    } else {
      throw Exception('Failed to load post');
    }
  }

  //upateCommentPost
  Future<bool> updateCommentPost(
      String userId, String postId, var comment) async {
    var urlPost = Config.post;
    var url = Uri.parse('$urlPost/$postId');
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

  //-------------------------------POST---------------------------------------------//

  //-------------------------------ARTICLE------------------------------------------//

  //create article
  Future<bool> createArticle(
      String title, String desc, String coverArticle, var tags) async {
    final storage = FlutterSecureStorage();
    var url = Uri.parse(Config.article);
    var userId = await storage.read(key: 'userId');
    final request = {
      'userId': userId,
      'title': title,
      'desc': desc,
      'tags' : tags,
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

  //fetch article from followed user
  Future<List<ArticleModel>> fetchArticle() async {
    var urlArticle = Config.timelineArticleApi;
    var userId = await storage.read(key: 'userId');
    var url = Uri.parse('${urlArticle}/${userId}');
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
  Future<ArticleModel> fetchSingleArticle([String? id]) async {
    var urlArticle = Config.article;
    var url = Uri.parse('$urlArticle/$id');
    var response = await client.get(url);
    if (response.statusCode == 200) {
      var data = ArticleModel.fromMap(jsonDecode(response.body));
      return data;
    } else {
      return Future.error(Icons.error);
    }
  }

  //update article by id
  Future<bool> updateArticle(
      String idArticle, String coverArticle, String desc, String title, var tags) async {
    var urlArticle = Config.article;
    var userId = await storage.read(key: 'userId');
    var url = Uri.parse('$urlArticle/$idArticle');
    final request = {
      'userId': userId,
      'title': title,
      'desc': desc,
      'tags' : tags,
      'coverArticle': coverArticle
    };
    final response = await http.put(url,
        body: jsonEncode(request),
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode != 200) {
      print('update article failed');
      return false;
    } else {
      print('update article success');
      return true;
    }
  }

  //update comment
  Future<bool> updateComment(
      String userId, String articleId, var comment) async {
    var urlArticle = Config.article;
    var url = Uri.parse('$urlArticle/$articleId');
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

  //delete article
  static Future<bool> deleteArticle(String articleId) async {
    final storage = FlutterSecureStorage();
    var urlArticle = Config.article;
    var url = Uri.parse('$urlArticle/$articleId');
    var userId = await storage.read(key: 'userId');
    final request = {'userId': userId};
    var response = await client.delete(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(request));

    if (response.statusCode != 200) {
      print('delete article failed');
      return false;
    } else {
      print('delet article success');
      return true;
    }
  }

  //-------------------------------ARTICLE------------------------------------------//

  //-------------------------------ACTIVITY-----------------------------------------//

  //update activity
  Future<bool> updateActivity(String idActivity, String title, String type,
      String image, String desc, String startDate, String endDate) async {
    var urlActivity = Config.activity;
    var url = Uri.parse('$urlActivity/$idActivity');
    var userId = await storage.read(key: 'userId');
    final request = {
      'userId': userId,
      'image': image,
      'title': title,
      'type': type,
      'desc': desc,
      'startDate': startDate,
      'endDate': endDate
    };
    final response = await http.put(url,
        body: jsonEncode(request),
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode != 200) {
      print('update activity failed');
      return false;
    } else {
      print('update activity success');
      return true;
    }
  }

  //delete activity
  Future<bool> deleteActivity(String activityId) async {
    var urlActivity = Config.activity;
    var url = Uri.parse('$urlActivity/$activityId');
    var userId = await storage.read(key: 'userId');
    final request = {'userId': userId};
    var response = await client.delete(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(request));
    if (response.statusCode != 200) {
      print('delete activity failed');
      return false;
    } else {
      print('delete activity success');
      return true;
    }
  }

  //get last by user activity
  Future<ActivityModel> fetchLastActivity([String? userId]) async {
    var url;
    var urlActivity = Config.fetchUserActivities;
    if (userId == null) {
      var userId = await storage.read(key: 'userId');
      url = Uri.parse('$urlActivity/last/$userId');
    } else {
      url = Uri.parse('$urlActivity/last/$userId');
    }

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return ActivityModel.fromMap(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load activity');
    }
  }

  //fetch activity by user
  Future<List<ActivityModel>> fetchAnyActivity([String? userId]) async {
    var url;
    var urlActivity = Config.fetchUserActivities;

    if (userId == null) {
      final storage = FlutterSecureStorage();
      var userId = await storage.read(key: 'userId');
      url = Uri.parse('$urlActivity/all/$userId');
    } else {
      url = Uri.parse('$urlActivity/all/$userId');
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
  Future<bool> createActivity(String title, String type, String image,
      String desc, String startDate, String endDate) async {
    var url = Uri.parse(Config.activity);
    var userId = await storage.read(key: 'userId');
    final request = {
      'userId': userId,
      'image': image,
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

  //fetch single activities
  Future<ActivityModel> fetchSingleActivity([String? id]) async {
    var urlActivity = Config.activity;
    var url = Uri.parse('$urlActivity/$id');
    var response = await client.get(url);
    if (response.statusCode == 200) {
      var data = ActivityModel.fromMap(jsonDecode(response.body));
      return data;
    } else {
      return Future.error(Icons.error);
    }
  }

  //create/update/delete task
  Future<bool> updateActivityTask(var tasks, String activityId) async {
    var urlActivity = Config.activity;
    var url = Uri.parse('$urlActivity/$activityId');
    var userId = await storage.read(key: 'userId');
    final request = {
      'userId': userId,
      'tasks': tasks
    };
    final response = await client.put(url,
        body: jsonEncode(request),
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode != 200) {
      print('update task failed ${response.persistentConnection}');
      return false;
    } else {
      print('update task success');
      return true;
    }
  }

  //-------------------------------ACTIVITY-----------------------------------------//

  //--------------------------------BADGES-----------------------------------------//

  //delete badges
  Future<bool> deleteBadge(String badgeId) async {
    var urlBadge = Config.badges;
    var url = Uri.parse('$urlBadge/$badgeId');
    var userId = await storage.read(key: 'userId');
    final request = {'userId': userId};
    var response = await client.delete(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(request));
    if (response.statusCode != 200) {
      print('delete badge failed');
      return false;
    } else {
      print('delete badge success');
      return true;
    }
  }

  //update badges
  Future<bool> updateBadge(
      String idBadge,
      String imgBadge,
      String title,
      String issuer,
      String urlLearn,
      String earnedDate,
      String desc,
      var skills) async {
    final storage = FlutterSecureStorage();
    var urlBadges = Config.badges;
    var url = Uri.parse('$urlBadges/$idBadge');
    var userId = await storage.read(key: 'userId');
    final request = {
      'userId': userId,
      'imgBadge': imgBadge,
      'title': title,
      'issuer': issuer,
      'url': urlLearn,
      'earnedDate': earnedDate,
      'desc': desc,
      'skills': skills
    };
    final response = await http.put(url,
        body: jsonEncode(request),
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode != 200) {
      print('update badge failed');
      return false;
    } else {
      print('update badge success');
      return true;
    }
  }

  //fetch single badges by id
  Future<BadgesModel> fetchSingleBadges([String? id]) async {
    var urlBagdes = Config.badges;
    var url = Uri.parse('$urlBagdes/$id');
    var response = await client.get(url);
    if (response.statusCode == 200) {
      var data = BadgesModel.fromMap(jsonDecode(response.body));
      return data;
    } else {
      return Future.error(Icons.error);
    }
  }

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
      String urlLearn, String earnedDate, String desc, var skills) async {
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
      'desc': desc,
      'skills': skills
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

  //--------------------------------BADGES-----------------------------------------//

  //---------------------------------ALBUM-----------------------------------------//

  //fetch album by user
  Future<List<AlbumModel>> fetchAnyAlbum([String? userId]) async {
    var url;
    var urlAlbum = Config.album;

    if (userId == null) {
      final storage = FlutterSecureStorage();
      var userId = await storage.read(key: 'userId');
      url = Uri.parse('$urlAlbum/all/$userId');
    } else {
      url = Uri.parse('$urlAlbum/all/$userId');
    }

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed
          .map<AlbumModel>((json) => AlbumModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load article');
    }
  }

  //upload image album
  Future<bool> uploadAlbumImage(String path, var filename, var size) async {
    var userId = await storage.read(key: 'userId');
    String? mimeType = mime(filename);
    String mimee = mimeType!.split('/')[0];
    String type = mimeType.split('/')[1];
    var formData = Dio.FormData.fromMap({
      'userId': userId,
      'filename': filename,
      'filesize': size,
      'type': 'image',
      'fileAlbum': await Dio.MultipartFile.fromFile(path,
          filename: filename, contentType: MediaType(mimee, type)),
    });
    Dio.Response response = await Dio.Dio().post(Config.album, data: formData);
    if (response.statusCode != 200) {
      print('tidak berhasil');
      return false;
    } else {
      print(response.data.toString());
      return true;
    }
  }

  //upload video album
  Future<bool> uploadAlbumVideo(String path, var filename, var size) async {
    var userId = await storage.read(key: 'userId');
    String? mimeType = mime(filename);
    String mimee = mimeType!.split('/')[0];
    String type = mimeType.split('/')[1];
    var formData = Dio.FormData.fromMap({
      'userId': userId,
      'filename': filename,
      'filesize': size,
      'type': 'video',
      'fileAlbum': await Dio.MultipartFile.fromFile(path,
          filename: filename, contentType: MediaType(mimee, type)),
    });
    Dio.Response response =
        await Dio.Dio().post('${Config.album}/video', data: formData);
    if (response.statusCode != 200) {
      print('tidak berhasil');
      return false;
    } else {
      print(response.data.toString());
      return true;
    }
  }

  //delete file album
  Future<bool> deleteAlbum(String albumId) async {
    var urlAlbum = Config.album;
    var url = Uri.parse('$urlAlbum/$albumId');
    var userId = await storage.read(key: 'userId');
    final request = {'userId': userId};
    var response = await http.delete(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(request));

    if (response.statusCode != 200) {
      print('delete post failed');
      return false;
    } else {
      print('delete post success');
      return true;
    }
  }

//---------------------------------ALBUM-----------------------------------------//

//---------------------------------PROJECT-----------------------------------------//

  //delete project
  Future<bool> deleteProject(String idProject) async {
    var urlProject = Config.project;
    var url = Uri.parse('$urlProject/$idProject');
    var userId = await storage.read(key: 'userId');
    final request = {'userId': userId};
    var response = await client.delete(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(request));
    if (response.statusCode != 200) {
      print('delete project failed');
      return false;
    } else {
      print('delete project success');
      return true;
    }
  }

  //update project
  Future<bool> updateProject(
      String idProject,
      String title, String type, String image,
      String desc, String startDate, String endDate, bool isPublic) async {
    var urlProject = Config.project;
    var url = Uri.parse('$urlProject/$idProject');
    var userId = await storage.read(key: 'userId');
    final request = {
      'userId': userId,
      'image': image,
      'title': title,
      'type': type,
      'desc': desc,
      'startDate': startDate,
      'endDate': endDate,
      'isPublic': isPublic
    };
    final response = await http.put(url,
        body: jsonEncode(request),
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode != 200) {
      print('update project failed');
      return false;
    } else {
      print('update project success');
      return true;
    }
  }

  //get suggessted project
  Future<List<ProjectModel>> fetchSuggestProject([String? userId]) async {
    var urlProject = Config.project;
    var userId = await storage.read(key: 'userId');
    var url = Uri.parse('$urlProject/suggest/$userId');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed
          .map<ProjectModel>((json) => ProjectModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load project');
    }
  }

  //request project
  Future<bool> requestProject(String idProject) async {
    final storage = FlutterSecureStorage();
    var urlProject = Config.project;
    var url = Uri.parse('$urlProject/request/$idProject');
    var userId = await storage.read(key: 'userId');
    final request = {'userId': userId};
    var response = await client.put(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(request));

    if (response.statusCode != 200) {
      print('request project failed');
      return false;
    } else {
      print('request project success');
      return true;
    }
  }

  //get any projects
  Future<List<ProjectModel>> fetchAnyProject([String? userId]) async {
    var url;
    var urlProject = Config.project;

    if (userId == null) {
      var userId = await storage.read(key: 'userId');
      url = Uri.parse('$urlProject/all/$userId');
    } else {
      url = Uri.parse('$urlProject/all/$userId');
    }

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed
          .map<ProjectModel>((json) => ProjectModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load project');
    }
  }

  //create project
  Future<bool> createProject(String title, String type, String image,
      String desc, String startDate, String endDate, bool isPublic) async {
    var url = Uri.parse(Config.project);
    var userId = await storage.read(key: 'userId');
    final request = {
      'userId': userId,
      'image': image,
      'title': title,
      'type': type,
      'desc': desc,
      'startDate': startDate,
      'endDate': endDate,
      'isPublic': isPublic
    };
    final response = await http.post(url,
        body: jsonEncode(request),
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode != 200) {
      print('create project failed');
      return false;
    } else {
      print('create project success');
      return true;
    }
  }

  //fetch single project
  Future<ProjectModel> fetchSingleProject([String? id]) async {
    var urlProject = Config.project;
    var url = Uri.parse('$urlProject/$id');
    var response = await client.get(url);
    if (response.statusCode == 200) {
      var data = ProjectModel.fromJson(jsonDecode(response.body));
      return data;
    } else {
      return Future.error(Icons.error);
    }
  }

  //create roadmap
  Future<bool> updateProjectRoadmap(var roadmap, String projectId) async {
    var urlRoadmap = Config.project;
    var url = Uri.parse('$urlRoadmap/$projectId');
    var userId = await storage.read(key: 'userId');
    final request = {'userId': userId, 'roadmaps': roadmap};
    final response = await http.put(url,
        body: json.encode(request),
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode != 200) {
      print('create roadmap failed');
      return false;
    } else {
      print('create roadmap success');
      return true;
    }
  }

  //fetch all request project
  Future<List<Notify>> fetchRequestedProject() async {
    var urlProject = Config.project;
    var userId = await storage.read(key: 'userId');
    var url = Uri.parse('$urlProject/allrequest/$userId');
    var response = await client.get(url);
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<Notify>((json) => Notify.fromJson(json)).toList();
    } else {
      return Future.error(Icons.error);
    }
  }

  //accept request project
  Future<bool> acceptProjectParticipant(String projectId, String userId) async {
    var urlProject = Config.project;
    var url = Uri.parse('$urlProject/accept/$projectId');
    final request = {
      'userId': userId,
    };
    final response = await client.put(url,
        body: jsonEncode(request),
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode != 200) {
      print('failed add participant!');
      return false;
    } else {
      print('Participant added!');
      return true;
    }
  }

  //decline request project
  Future<bool> declineProjectParticipant(
      String projectId, String userId) async {
    var urlProject = Config.project;
    var url = Uri.parse('$urlProject/cancelrequest/$projectId');
    final request = {
      'userId': userId,
    };
    final response = await client.put(url,
        body: jsonEncode(request),
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode != 200) {
      print('failed decline participant!');
      return false;
    } else {
      print('Participant declined!');
      return true;
    }
  }

//---------------------------------PROJECT-----------------------------------------//

}
