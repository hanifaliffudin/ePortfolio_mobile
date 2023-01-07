import 'dart:convert';

List<ActivityModel> postFromJson(String str) =>
    List<ActivityModel>.from(
        json.decode(str).map((x) => ActivityModel.fromMap(x)));

class ActivityModel {
  ActivityModel({
    required this.userId,
    required this.title,
    required this.type,
    required this.startDate,
    required this.desc,
    required this.isPublic,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.V,
  });

  late final String userId;
  late final String title;
  late final String type;
  late final String startDate;
  late final String desc;
  late final bool isPublic;
  late final String id;
  late final String createdAt;
  late final String updatedAt;
  late final int V;

  factory ActivityModel.fromMap(Map<String, dynamic> json) =>
      ActivityModel(userId: json['userId'],
          title: json['title'],
          type: json['type'],
          startDate: json['startDate'],
          desc: json['desc'],
          isPublic: json['isPublic'],
          id: json['_id'],
          createdAt: json['createdAt'],
          updatedAt: json['updatedAt'],
          V: json['__v']
      );


  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['userId'] = userId;
    _data['title'] = title;
    _data['type'] = type;
    _data['startDate'] = startDate;
    _data['desc'] = desc;
    _data['isPublic'] = isPublic;
    _data['_id'] = id;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    _data['__v'] = V;
    return _data;
  }
}