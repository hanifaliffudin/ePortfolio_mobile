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
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['userId'] = userId;
    _data['title'] = title;
    _data['type'] = type;
    _data['image'] = image;
    _data['startDate'] = startDate;
    _data['endDate'] = endDate;
    _data['desc'] = desc;
    _data['id'] = id;
    _data['tasks'] = tasks;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    return _data;
  }
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
  late final List<dynamic> images;
  late final String id;

  Tasks.fromJson(Map<String, dynamic> json){
    title = json['title'];
    date = json['date'];
    desc = json['desc'];
    images = List.castFrom<dynamic, dynamic>(json['images']);
    id = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['title'] = title;
    _data['date'] = date;
    _data['desc'] = desc;
    _data['images'] = images;
    _data['_id'] = id;
    return _data;
  }
}
