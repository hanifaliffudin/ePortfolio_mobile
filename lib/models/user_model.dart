class UserModel {
  String username;
  SocialMedia? socialMedia;
  String organization;
  String id;
  String role;
  String major;
  String nim;
  String profilePicture;
  String city;
  String gender;
  String dateBirth;
  String about;
  String interest;
  String academicField;

  UserModel(
      {required this.username,
      this.socialMedia,
      required this.organization,
      required this.id,
      required this.role,
      required this.major,
      required this.nim,
      required this.profilePicture,
      required this.city,
      required this.gender,
      required this.dateBirth,
      required this.about,
      required this.interest,
      required this.academicField});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        username: json['username'],
        socialMedia: SocialMedia.fromJson(json['socialMedia']),
        organization: json['organization'],
        id: json['_id'],
        role: json['role'],
        major: json['major'],
        nim: json['nim'],
        profilePicture: json['profilePicture'],
        city: json['city'],
        gender: json['gender'],
        dateBirth: json['dateBirth'],
        about: json['about'],
        interest: json['interest'],
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
