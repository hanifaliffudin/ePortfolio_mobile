import 'dart:convert';

List<ProjectModel> postFromJson(String str) => List<ProjectModel>.from(
    json.decode(str).map((x) => ProjectModel.fromJson(x)));

class ProjectModel {
  ProjectModel({
    required this.requests,
    required this.id,
    required this.userId,
    required this.title,
    required this.image,
    required this.type,
    required this.startDate,
    required this.endDate,
    required this.desc,
    required this.isPublic,
    required this.participants,
    required this.createdAt,
    required this.roadmaps,
    required this.updatedAt,
    required this.V,
  });

  late final List<dynamic> requests;
  late final String id;
  late final String userId;
  late final String title;
  String image;
  String type;
  String startDate;
  String endDate;
  late final String desc;
  late final bool isPublic;
  late final List<dynamic> participants;
  late final String createdAt;
  List<Roadmaps> roadmaps;
  late final String updatedAt;
  late final int V;

  factory ProjectModel.fromJson(Map<String, dynamic> json) => ProjectModel(
        requests: List.castFrom<dynamic, dynamic>(json['requests']),
        id: json['_id'],
        userId: json['userId'],
        title: json['title'],
        image: json['image'],
        type: json['type'],
        startDate: json['startDate'],
        endDate: json['endDate'],
        desc: json['desc'],
        isPublic: json['isPublic'],
        participants: List.castFrom<dynamic, dynamic>(json['participants']),
        createdAt: json['createdAt'],
        roadmaps: List.from(json['roadmaps'])
            .map((e) => Roadmaps.fromJson(e))
            .toList(),
        updatedAt: json['updatedAt'],
        V: json['__v'],
      );

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['requests'] = requests;
    _data['_id'] = id;
    _data['userId'] = userId;
    _data['title'] = title;
    _data['image'] = image;
    _data['type'] = type;
    _data['startDate'] = startDate;
    _data['endDate'] = endDate;
    _data['desc'] = desc;
    _data['isPublic'] = isPublic;
    _data['participants'] = participants;
    _data['createdAt'] = createdAt;
    _data['roadmaps'] = roadmaps.map((e) => e.toJson()).toList();
    _data['updatedAt'] = updatedAt;
    _data['__v'] = V;
    return _data;
  }
}

class Roadmaps {
  Roadmaps({
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.desc,
    required this.tasks,
    required this.id,
  });

  late final String title;
  late final String startDate;
  late final String endDate;
  late final String desc;
  late final List<Task> tasks;
  late final String id;

  Roadmaps.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    desc = json['desc'];
    tasks = List.from(json['tasks']).map((e) => Task.fromJson(e)).toList();
    id = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['title'] = title;
    _data['startDate'] = startDate;
    _data['endDate'] = endDate;
    _data['desc'] = desc;
    _data['tasks'] = tasks.map((e) => e.toJson()).toList();
    _data['_id'] = id;
    return _data;
  }
}

class Task {
  Task({
    required this.title,
    required this.date,
    required this.status,
    required this.images,
    required this.desc,
    required this.id,
    required this.todos,
  });

  late final String title;
  late final String date;
  late final String status;
  late final List<dynamic> images;
  late final String desc;
  late final String id;
  late final List<Todos> todos;

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        title: json['title'],
        date: json['date'],
        status: json['status'],
        images: List.castFrom<dynamic, dynamic>(json['images']),
        desc: json['desc'],
        id: json['_id'],
        todos: List.from(json['todos']).map((e) => Todos.fromJson(e)).toList(),
      );

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['title'] = title;
    _data['date'] = date;
    _data['status'] = status;
    _data['images'] = images;
    _data['desc'] = desc;
    _data['_id'] = id;
    _data['todos'] = todos.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Todos {
  Todos({
    required this.title,
    required this.done,
    required this.assignee,
    required this.report,
    required this.id,
  });

  late final String title;
  late final bool done;
  late final List<dynamic> assignee;
  late final String report;
  late final String id;

  factory Todos.fromJson(Map<String, dynamic> json) => Todos(
        title: json['title'],
        done: json['done'],
        report: json['report'],
        assignee: List.castFrom<dynamic, dynamic>(json['assignee']),
        id: json['_id'],
      );

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['title'] = title;
    _data['done'] = done;
    _data['assignee'] = assignee;
    _data['report'] = report;
    _data['_id'] = id;
    return _data;
  }
}
