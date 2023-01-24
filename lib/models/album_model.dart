import 'dart:convert';

List<AlbumModel> postFromJson(String str) =>
    List<AlbumModel>.from(
        json.decode(str).map((x) => AlbumModel.fromJson(x)));

class AlbumModel {
  String id;
  String userId;
  String filename;
  String type;
  int filesize;
  String fileAlbum;
  String createdAt;
  String updatedAt;
  int V;

  AlbumModel({
    required this.id,
    required this.userId,
    required this.filename,
    required this.type,
    required this.filesize,
    required this.fileAlbum,
    required this.createdAt,
    required this.updatedAt,
    required this.V,
  });


  factory AlbumModel.fromJson(Map<String, dynamic> json){
    return AlbumModel(id: json['_id'],
        userId: json['userId'],
        filename: json['filename'],
        type : json['type'],
        filesize: json['filesize'],
        fileAlbum: json['fileAlbum'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
        V: json['__v']
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['userId'] = userId;
    _data['filename'] = filename;
    _data['type'] = type;
    _data['filesize'] = filesize;
    _data['fileAlbum'] = fileAlbum;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    _data['__v'] = V;
    return _data;
  }
}