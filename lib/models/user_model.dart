class UserModel {
  String username;
  String id;
  String major;
  String nim;
  String profilePicture;
  String city;
  String gender;
  String dateBirth;
  String about;
  String interest;

  UserModel(
      {required this.username,
      required this.id,
      required this.major,
      required this.nim,
      required this.profilePicture,
      required this.city,
      required this.gender,
      required this.dateBirth,
      required this.about,
      required this.interest});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        username: json['username'],
        id: json['_id'],
        major: json['major'],
        nim: json['nim'],
        profilePicture: json['profilePicture'],
        city: json['city'],
        gender: json['gender'],
        dateBirth: json['dateBirth'],
        about: json['about'],
        interest: json['interest']);
  }
}
