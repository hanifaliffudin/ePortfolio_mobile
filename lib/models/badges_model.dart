class BadgesModel {
  BadgesModel({
    required this.id,
    required this.userId,
    required this.imgBadge,
    required this.title,
    required this.issuer,
    required this.earnedDate,
    required this.desc,
    required this.createdAt,
    required this.updatedAt,
    required this.V,
  });

  late final String id;
  late final String userId;
  late final String imgBadge;
  late final String title;
  late final String issuer;
  late final String earnedDate;
  late final String desc;
  late final String createdAt;
  late final String updatedAt;
  late final int V;

  factory BadgesModel.fromMap(Map<String, dynamic> json) =>
      BadgesModel(
          id: json['_id'],
          userId: json['userId'],
          imgBadge: json['imgBadge'],
          title: json['title'],
          issuer: json['issuer'],
          earnedDate: json['earnedDate'],
          desc: json['desc'],
          createdAt: json['createdAt'],
          updatedAt: json['updatedAt'],
          V: json['__v']);


  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['userId'] = userId;
    _data['imgBadge'] = imgBadge;
    _data['title'] = title;
    _data['issuer'] = issuer;
    _data['earnedDate'] = earnedDate;
    _data['desc'] = desc;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    _data['__v'] = V;
    return _data;
  }
}