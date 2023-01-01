import 'dart:convert';

List<ArticleModel> postFromJson(String str) =>
    List<ArticleModel>.from(
        json.decode(str).map((x) => ArticleModel.fromMap(x)));

class ArticleModel {
  String id;
  String userId;
  String title;
  String desc;
  String coverArticle;
  bool isPublic;
  List<String> tags;
  String createdAt;
  List<Comments> comments;
  String updatedAt;
  int V;

  ArticleModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.desc,
    required this.coverArticle,
    required this.isPublic,
    required this.tags,
    required this.createdAt,
    required this.comments,
    required this.updatedAt,
    required this.V,
  });

  factory ArticleModel.fromMap(Map<String, dynamic> json) => ArticleModel(
        id: json['_id'],
        userId: json['userId'],
        title: json['title'],
        desc: json['desc'],
        coverArticle: json['coverArticle'],
        isPublic: json['isPublic'],
        tags: List.castFrom<dynamic, String>(json['tags']),
        createdAt: json['createdAt'],
        comments: List.from(json['comments'])
            .map((e) => Comments.fromJson(e))
            .toList(),
        updatedAt: json['updatedAt'],
        V: json['__v'],
      );

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['userId'] = userId;
    _data['title'] = title;
    _data['desc'] = desc;
    _data['coverArticle'] = coverArticle;
    _data['isPublic'] = isPublic;
    _data['tags'] = tags;
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
