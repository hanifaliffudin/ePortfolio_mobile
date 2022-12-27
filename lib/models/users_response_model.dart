class UsersModel {
  UsersModel({
    this.socialMedia,
    this.role,
    this.academicField,
    this.id,
    this.username,
    this.email,
    this.skill,
    this.blockProfile,
    this.createdAt,
    this.V,
    this.about,
    this.isAdmin,
    this.city,
    this.profilePicture,
    this.dateBirth,
    this.gender,
    this.interest,
    this.major,
    this.nim,
  });

  late SocialMedia? socialMedia;
  late String? role;
  late String? academicField;
  late String? id;
  late String? username;
  late String? email;
  late List<dynamic>? skill;
  late List<dynamic>? blockProfile;
  late String? createdAt;
  late int? V;
  late String? about;
  late bool? isAdmin;
  late String? city;
  late String? profilePicture;
  late String? dateBirth;
  late String? gender;
  late String? interest;
  late String? major;
  late String? nim;

  factory UsersModel.fromJson(Map<String, dynamic> json) {
    return UsersModel(
      socialMedia: SocialMedia.fromJson(json['socialMedia']),
      role: json['role'],
      academicField: json['academicField'],
      id: json['_id'],
      username: json['username'],
      email: json['email'],
      skill: List.castFrom<dynamic, dynamic>(json['skill']),
      blockProfile: List.castFrom<dynamic, dynamic>(json['blockProfile']),
      createdAt: json['createdAt'],
      V: json['__v'],
      about: json['about'],
      isAdmin: json['isAdmin'],
      city: json['city'],
      profilePicture: json['profilePicture'],
      dateBirth: json['dateBirth'],
      gender: json['gender'],
      interest: json['interest'],
      major: json['major'],
      nim: json['nim'],
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['socialMedia'] = socialMedia?.toJson();
    _data['role'] = role;
    _data['academicField'] = academicField;
    _data['_id'] = id;
    _data['username'] = username;
    _data['email'] = email;
    _data['skill'] = skill;
    _data['blockProfile'] = blockProfile;
    _data['createdAt'] = createdAt;
    _data['__v'] = V;
    _data['about'] = about;
    _data['isAdmin'] = isAdmin;
    _data['city'] = city;
    _data['profilePicture'] = profilePicture;
    _data['dateBirth'] = dateBirth;
    _data['gender'] = gender;
    _data['interest'] = interest;
    _data['major'] = major;
    _data['nim'] = nim;
    return _data;
  }
}

class SocialMedia {
  SocialMedia({
    required this.linkedin,
    required this.github,
    required this.instagram,
    required this.facebook,
    required this.twitter,
  });

  late final String linkedin;
  late final String github;
  late final String instagram;
  late final String facebook;
  late final String twitter;

  SocialMedia.fromJson(Map<String, dynamic> json) {
    linkedin = json['linkedin'];
    github = json['github'];
    instagram = json['instagram'];
    facebook = json['facebook'];
    twitter = json['twitter'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['linkedin'] = linkedin;
    _data['github'] = github;
    _data['instagram'] = instagram;
    _data['facebook'] = facebook;
    _data['twitter'] = twitter;
    return _data;
  }
}
