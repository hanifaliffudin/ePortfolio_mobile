class UserModel{
  late String? socialMedia;
  late List<dynamic>? blockProfile;
  late String? id;
  late String? username;
  late String? email;
  late String? profilePicture;
  late String? nim;
  late String? major;
  late String? city;
  late String? interest;
  late String? about;
  late List<String>? skill;
  late bool? isAdmin;
  late String? createdAt;
  late int? V;
  late String? dateBirth;
  late String? gender;

  UserModel(
    this.socialMedia,
    this.blockProfile,
    this.id,
    this.username,
    this.email,
    this.profilePicture,
    this.nim,
    this.major,
    this.city,
    this.interest,
    this.about,
    this.skill,
    this.isAdmin,
    this.createdAt,
    this.V,
    this.dateBirth,
    this.gender,
  );
}