import 'dart:convert';

List<ActivityModel> postFromJson(String str) =>
    List<ActivityModel>.from(
        json.decode(str).map((x) => ActivityModel.fromMap(x)));

class ActivityModel {
  ActivityModel({
    required this.userId,
    required this.title,
    required this.type,
    required this.image,
    required this.startDate,
    required this.endDate,
    required this.desc,
    required this.isPublic,
    required this.id,
    required this.tasks,
    required this.createdAt,
    required this.updatedAt,
    required this.V,
  });

  late final String userId;
  late final String title;
  late final String type;
  late final String image;
  late final String startDate;
  late final String endDate;
  late final String desc;
  late final bool isPublic;
  late final String id;
  late final List<Tasks> tasks;
  late final String createdAt;
  late final String updatedAt;
  late final int V;

  factory ActivityModel.fromMap(Map<String, dynamic> json) =>
      ActivityModel(userId: json['userId'],
          title: json['title'],
          type: json['type'],
          image: json['image'],
          startDate: json['startDate'],
          endDate: json['endDate'],
          desc: json['desc'],
          isPublic: json['isPublic'],
          id: json['_id'],
          tasks : List.from(json['tasks']).map((e)=>Tasks.fromJson(e)).toList(),
          createdAt: json['createdAt'],
          updatedAt: json['updatedAt'],
          V: json['__v']
      );
}

class Tasks {
  Tasks({
    required this.title,
    required this.date,
    required this.desc,
    required this.images,
    required this.id,
  });
  late final String title;
  late final String date;
  late final String desc;
  late final List<Images> images;
  late final String id;

  Tasks.fromJson(Map<String, dynamic> json){
    title = json['title'];
    date = json['date'];
    desc = json['desc'];
    images = List.from(json['images']).map((e)=>Images.fromJson(e)).toList();
    id = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['title'] = title;
    _data['date'] = date;
    _data['desc'] = desc;
    _data['images'] = images.map((e)=>e.toJson()).toList();
    _data['_id'] = id;
    return _data;
  }
}

class Images {
  Images({
    required this.name,
    required this.imgurl,
    required this.id,
  });

  late final String name;
  late final String imgurl;
  late final String id;

  Images.fromJson(Map<String, dynamic> json){
    name = json['name'];
    imgurl = json['imgurl'];
    id = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['imgurl'] = imgurl;
    _data['_id'] = id;
    return _data;
  }
}