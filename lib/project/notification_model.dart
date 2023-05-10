import 'dart:convert';

List<Notify> notifFromJson(String str) => List<Notify>.from(
    json.decode(str).map((x) => Notify.fromJson(x)));

class Notify {
  Notify({required this.projectId, required this.userId});

  late final String projectId;
  late final String userId;

  factory Notify.fromJson(Map<String, dynamic> json) =>
      Notify(projectId: json['projectId'], userId: json['userId']);
}