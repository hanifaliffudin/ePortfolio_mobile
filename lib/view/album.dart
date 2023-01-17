import 'dart:convert';

import 'package:eportfolio/config.dart';
import 'package:eportfolio/view/video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:mime_type/mime_type.dart';
import 'package:video_thumbnail_imageview/video_thumbnail_imageview.dart';
import '../models/album_model.dart';
import '../models/post_model.dart';
import '../services/api_service.dart';

class Album extends StatefulWidget {
  @override
  _AlbumState createState() => _AlbumState();
}

class _AlbumState extends State<Album> {
  late Future<List<AlbumModel>> futureAlbum;
  var userId;
  var data;
  String? username;
  late PostModel postData;

  Future<Map<String, dynamic>> getIdUser() async {
    final storage = FlutterSecureStorage();
    userId = await storage.read(key: 'userId');
    data = await APIService.getIdUser(postData.userId);
    username = data['username'];
    return data;
  }

  @override
  void initState() {
    super.initState();
    futureAlbum = APIService().fetchAnyAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<AlbumModel>>(
      future: futureAlbum,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          return Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 5, right: 5, top: 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    minimumSize: const Size.fromHeight(35), // NEW
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(10.0))),
                        builder: (context) => Padding(
                              padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom),
                              child: Container(
                                  height: 120,
                                  margin: EdgeInsets.only(
                                      left: 10, top: 10, right: 10),
                                  child: Column(
                                    children: [
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(),
                                          onPressed: () {
                                            uploadFile();
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('Add photo'),
                                              Icon(Icons.photo)
                                            ],
                                          )),
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(),
                                          onPressed: () {
                                            uploadFileVideo();
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('Add video'),
                                              Icon(Icons.ondemand_video)
                                            ],
                                          )),
                                    ],
                                  )),
                            ));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Add Photo/Video',
                        style: TextStyle(fontSize: 15),
                      ),
                      Icon(Icons.add)
                    ],
                  ),
                ),
              ),
              GridView.count(
                  padding: EdgeInsets.all(5),
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  childAspectRatio: 1.0,
                  children: List.generate(snapshot.data!.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          snapshot.data![index].type == 'image'
                              ? GestureDetector(
                                  onTap: () async {
                                    await showDialog(
                                        context: context,
                                        builder: (_) => imageDialog(
                                            snapshot.data![index].filename,
                                            snapshot.data![index].fileAlbum));
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.network(
                                      '${Config.apiURL}/${snapshot.data![index].fileAlbum}',
                                      fit: BoxFit.cover,
                                      width: 200,
                                      height: 175,
                                    ),
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () async {
                                    await showDialog(
                                      context: context,
                                      builder: (_) => PlayVid(
                                        urlVideo:
                                            '${Config.apiURL}/${snapshot.data![index].fileAlbum}',
                                        nameVideo:
                                            '${snapshot.data![index].filename}',
                                      ),
                                    );
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: VTImageView(
                                      videoUrl:
                                          '${Config.apiURL}/${snapshot.data![index].fileAlbum}',
                                      assetPlaceHolder:
                                          'assets/images/video-playe.jpeg',
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    );
                  })),
            ],
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 25,
                ),
                SizedBox(
                  height: 10,
                ),
                Text('Something Went Wrong')
              ],
            ),
          );
        } else
          return CircularProgressIndicator();
      },
    );
  }

  void uploadFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg', 'jpeg'],
    );
    if (result != null) {
      PlatformFile file = result.files.first;
      var path = file.path.toString();
      var filename = file.name;
      String? mimeType = mime(filename);
      String mimee = mimeType!.split('/')[0];
      String type = mimeType.split('/')[1];
      var name = file.name;
      var size = file.size;
      var dataFile = {
        'userId': userId,
        'filename': name,
        'filesize': size,
        'type': 'image',
      };
      var formData = FormData.fromMap({
        'data': json.encode(dataFile),
        'fileAlbum': await MultipartFile.fromFile(path,
            filename: filename, contentType: new MediaType(mimee, type)),
      });
      Response response = await Dio().post(Config.album, data: formData);
      print(response.data.toString());
    } else {
      print('File not found');
    }
  }

  void uploadFileVideo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp4', 'webm', 'quicktime'],
    );
    if (result != null) {
      PlatformFile file = result.files.first;
      var path = file.path.toString();
      var filename = file.name;
      String? mimeType = mime(filename);
      String mimee = mimeType!.split('/')[0];
      String type = mimeType.split('/')[1];
      print(file.name);
      print(file.size);
      print(file.extension);
      print(file.path);
      var formData = FormData.fromMap({
        'userId': userId,
        'filename': file.name,
        'filesize': file.size,
        'type': 'video',
        'fileAlbum': await MultipartFile.fromFile(path,
            filename: filename, contentType: new MediaType(mimee, type)),
      });
      Response response =
          await Dio().post('${Config.album}/video', data: formData);
      print(response.data.toString());
    } else {
      print('File not found');
    }
  }

  void settingButton(context) {
    showModalBottomSheet(
        context: context,
        builder: (context) => Container(
              height: 70,
              margin: EdgeInsets.only(left: 10, top: 10, right: 10),
              child: Column(
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(),
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text('Delete'), Icon(Icons.delete)],
                      )),
                ],
              ),
            ));
  }

  Widget imageDialog(String imageName, String imageNetwork) {
    return Dialog(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 220,
                      child: Text(
                        '${imageName}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    settingButton(context);
                  },
                  icon: Icon(Icons.more_horiz),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              child: Image.network(
                '${Config.apiURL}/${imageNetwork}',
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Copy url : ',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Container(
                    width: 220,
                    child: SelectableText('${Config.apiURL}/${imageNetwork}',
                        style: TextStyle(fontSize: 18)),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
