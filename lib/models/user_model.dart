class UserModel {
  String username;
  SocialMedia? socialMedia;
  String organization;
  String id;
  List<dynamic> skill;
  String role;
  String major;
  String nim;
  List<dynamic> blockProfile;
  String profilePicture;
  String city;
  String gender;
  String dateBirth;
  String about;
  String interest;
  List<String> followers;
  List<String> following;
  String academicField;

  UserModel(
      {required this.username,
      this.socialMedia,
      required this.organization,
      required this.id,
        required this.skill,
      required this.role,
      required this.major,
      required this.nim,
        required this.blockProfile,
      required this.profilePicture,
      required this.city,
      required this.gender,
      required this.dateBirth,
      required this.about,
      required this.interest,
        required this.followers,
        required this.following,
      required this.academicField});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        username: json['username'],
        socialMedia: SocialMedia.fromJson(json['socialMedia']),
        organization: json['organization'],
        id: json['_id'],
        skill : List.castFrom<dynamic, dynamic>(json['skill']),
        role: json['role'],
        major: json['major'],
        nim: json['nim'],
        blockProfile : List.castFrom<dynamic, dynamic>(json['blockProfile']),
        profilePicture: json['profilePicture'],
        city: json['city'],
        gender: json['gender'],
        dateBirth: json['dateBirth'],
        about: json['about'],
        interest: json['interest'],
        followers : List.castFrom<dynamic, String>(json['followers']),
        following : List.castFrom<dynamic, String>(json['following']),
        academicField: json['academicField']
    );
  }
}

class SocialMedia {
  String? linkedin;
  String? github;
  String? instagram;
  String? facebook;
  String? twitter;

  SocialMedia({
    this.linkedin,
    this.github,
    this.instagram,
    this.facebook,
    this.twitter,
  });

  factory SocialMedia.fromJson(Map<String, dynamic> json){
    return SocialMedia(
      linkedin: json['linkedin'],
      github: json['github'],
      instagram: json['instagram'],
      facebook: json['facebook'],
      twitter: json['twitter']??'',
    );
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
