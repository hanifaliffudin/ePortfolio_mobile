import 'dart:convert';

List<PostResponseModel> postFromJson(String str) =>
    List<PostResponseModel>.from(
        json.decode(str).map((x) => PostResponseModel.fromMap(x)));

class PostResponseModel {
   String id;
   String userId;
   String desc;
   bool isPublic;
   String createdAt;
   List<Comments> comments;
   String updatedAt;
   int V;

  PostResponseModel({
    required this.id,
    required this.userId,
    required this.desc,
    required this.isPublic,
    required this.createdAt,
    required this.comments,
    required this.updatedAt,
    required this.V,
  });

  factory PostResponseModel.fromMap(
          Map<String, dynamic> json) =>
      PostResponseModel(
          id: json['_id'],
          userId: json['userId'],
          desc: json['desc'],
          isPublic: json['isPublic'],
          createdAt: json['createdAt'],
          comments: List.from(json['comments'])
              .map((e) => Comments.fromJson(e))
              .toList(),
          updatedAt: json['updatedAt'],
          V: json['__v']);

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['userId'] = userId;
    _data['desc'] = desc;
    _data['isPublic'] = isPublic;
    _data['createdAt'] = createdAt;
    _data['comments'] = comments.map((e) => e.toJson()).toList();
    _data['updatedAt'] = updatedAt;
    _data['__v'] = V;
    return _data;
  }
}

class Comments {
  Comments({
    required this.userId,
    required this.comment,
    required this.id,
    required this.date,
  });

  final String userId;
  final String comment;
  final String id;
  final String date;



  factory Comments.fromJson(Map<String, dynamic> json) {
    return Comments(
        userId: json['userId'],
        comment: json['comment'],
        id: json['_id'],
        date: json['date']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['userId'] = userId;
    _data['comment'] = comment;
    _data['_id'] = id;
    _data['date'] = date;
    return _data;
  }
}
