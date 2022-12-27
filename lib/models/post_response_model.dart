class PostResponseModel {
  PostResponseModel({
    this.userId,
    this.desc,
    this.isPublic,
    this.id,
    this.createdAt,
    this.comments,
    this.updatedAt,
    this.V,
  });
  late String? userId;
  late String? desc;
  late bool? isPublic;
  late String? id;
  late String? createdAt;
  late List<dynamic>? comments;
  late String? updatedAt;
  late int? V;

  PostResponseModel.fromJson(Map<String, dynamic> json){
    userId = json['userId'];
    desc = json['desc'];
    isPublic = json['isPublic'];
    id = json['_id'];
    createdAt = json['createdAt'];
    comments = List.castFrom<dynamic, dynamic>(json['comments']);
    updatedAt = json['updatedAt'];
    V = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['userId'] = userId;
    _data['desc'] = desc;
    _data['isPublic'] = isPublic;
    _data['_id'] = id;
    _data['createdAt'] = createdAt;
    _data['comments'] = comments;
    _data['updatedAt'] = updatedAt;
    _data['__v'] = V;
    return _data;
  }
}