import 'package:eportfolio/config.dart';
import 'package:eportfolio/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

import '../../models/project_model.dart';
import '../../models/user_model.dart';

class FriendProfileHeader extends StatefulWidget {
  FriendProfileHeader({required this.userId});
  String userId;

  @override
  State<FriendProfileHeader> createState() => _FriendProfileHeaderState(userId);
}

class _FriendProfileHeaderState extends State<FriendProfileHeader> {

  late Future<UserModel> futureFriend;
  late Future<List<ProjectModel>> futureProject;
  String userId;
  var userIdLogin;
  var data;
  var followers;
  _FriendProfileHeaderState(this.userId);

  Future<Map<String, dynamic>> getIdUser() async {
    final storage = FlutterSecureStorage();
    userIdLogin = await storage.read(key: 'userId');
    data = await APIService.getIdUser(userId);
    followers = data['followers'];
    return data;
  }

  @override
  void initState() {
    super.initState();
    futureFriend = APIService().fetchAnyUser(userId);
    futureProject = APIService().fetchAnyProject(userId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel>(
        future: futureFriend,
        builder: (context, snapshot){
          if(snapshot.hasData){
            return Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  width: 120,
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.all(10),
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      (snapshot.data!.profilePicture ==
                                          null ||
                                          snapshot.data!.profilePicture ==
                                              "")
                                          ? "https://ceblog.s3.amazonaws.com/wp-content/uploads/2018/08/20142340/best-homepage-9.png"
                                          : '${Config.apiURL}/${snapshot.data!.profilePicture.toString()}',
                                    ), radius: 60,
                                  )
                              ),
                            ],
                          ),
                          SizedBox(width: 8,),
                          Container(
                            width: 200,
                            child: snapshot.data!.role == 'dosen' ?
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(snapshot.data!.username ?? '',
                                    style: TextStyle(
                                        fontSize: 20, fontWeight: FontWeight.bold)),
                                SizedBox(
                                  height: 5,
                                ),
                                Text('Lecturer',
                                    style: TextStyle(fontWeight: FontWeight.w600)),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(snapshot.data!.academicField ?? ''),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(snapshot.data!.city ?? ''),
                              ],
                            )
                                :
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(snapshot.data!.username ?? '',
                                    style: TextStyle(
                                        fontSize: 20, fontWeight: FontWeight.bold)),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(snapshot.data!.nim ?? '',
                                    style: TextStyle(fontWeight: FontWeight.w600)),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(snapshot.data!.major ?? ''),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(snapshot.data!.city ?? ''),
                              ],
                            ),
                          )
                          //SizedBox(height: 10,),
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    FutureBuilder<List<ProjectModel>>(
                      future: APIService().fetchAnyProject(userId),
                      builder: (context, snapshot){
                        if(snapshot.hasData){
                          return InkWell(
                            onTap:  (){ DefaultTabController.of(context)?.index =6;},
                            child: Column(
                              children: [
                                Text(
                                  snapshot.data!.length.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 18),
                                ),
                                Text('Projects', style: TextStyle(fontSize: 12))
                              ],
                            ),
                          );
                        }else return CircularProgressIndicator();
                      },
                    ),
                    InkWell(
                      onTap: () async {
                        await showDialog(
                            context: context,
                            builder:
                                (_) => follower(snapshot.data!.followers.length));
                      },
                      child: Column(
                        children: [
                          Text(snapshot.data!.followers.length.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18)),
                          Text('Followers', style: TextStyle(fontSize: 12))
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: ()async{
                        await showDialog(
                            context: context,
                            builder:
                                (_) => following(snapshot.data!.following.length));
                      },
                      child: Column(
                        children: [
                          Text(snapshot.data!.following.length.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18)),
                          Text('Following', style: TextStyle(fontSize: 12))
                        ],
                      ),
                    )
                  ],
                ),
                Divider(),
                FutureBuilder(
                  future: getIdUser(),
                  builder: (context,snapshot){
                    if(snapshot.hasData){
                      return Container(
                        child:
                        followers.contains(userIdLogin) ?
                        Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child:
                          ElevatedButton(
                              onPressed: () {
                                APIService().unfollow(
                                    userId)
                                    .then((response) {
                                  if (response) {
                                    setState(() {
                                      // followed = false;
                                      // print(followed);
                                    });
                                    FormHelper.showSimpleAlertDialog(
                                      context,
                                      "Success!",
                                      "Success unfollow user",
                                      "OK",
                                          () {
                                        Navigator.of(context).pop();
                                      },
                                    );
                                  } else {
                                    FormHelper.showSimpleAlertDialog(
                                      context,
                                      "Error!",
                                      "Failed unfollow user! Please try again",
                                      "OK",
                                          () {
                                        Navigator.of(context).pop();
                                      },
                                    );
                                  }
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.grey,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Text('Unfollow'),
                                      Icon(Icons.remove_circle_outline),
                                    ],
                                  )
                                ],
                              )),
                        ) :
                        Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child:
                          ElevatedButton(
                              onPressed: () {
                                APIService().follow(
                                   userId)
                                    .then((response) {
                                  if (response) {
                                    setState(() {
                                      // followed = true;
                                      // print(followed);
                                    });
                                    FormHelper.showSimpleAlertDialog(
                                      context,
                                      "Success!",
                                      "Success follow user",
                                      "OK",
                                          () {
                                        Navigator.of(context).pop();
                                      },
                                    );
                                  } else {
                                    FormHelper.showSimpleAlertDialog(
                                      context,
                                      "Error!",
                                      "Failed follow user! Please try again",
                                      "OK",
                                          () {
                                        Navigator.of(context).pop();
                                      },
                                    );
                                  }
                                });

                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Text('Follow'),
                                      Icon(Icons.add_circle_outline),
                                    ],
                                  )
                                ],
                              )),
                        ),
                      );
                    } else return CircularProgressIndicator();
                  },
                )
              ],
            );
          } else {
            return CircularProgressIndicator();
          }
        }
    );
  }

  Widget follower(int follow) {
    return FutureBuilder<UserModel>(
      future: futureFriend,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          if(follow == 0){
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(20.0),
              ),
              clipBehavior: Clip.antiAlias,
              child: ListView(
                shrinkWrap: true,
                children: [
                  ListTile(
                    title: Center(child: Text('No Follower')),
                  )
                ],
              ),
            );
          }
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(20.0),
            ),
            clipBehavior: Clip.antiAlias,
            child: ListView.builder(
                physics:
                NeverScrollableScrollPhysics(),
                itemCount: follow,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return FutureBuilder<UserModel>(
                    future: APIService().fetchAnyUser(snapshot.data!.followers[index]),
                    builder: (context, snapshot){
                      if(snapshot.hasData){
                        return InkWell(
                          onTap: (){
                            Navigator.pushNamed(context, '/friendprofile',
                                arguments: snapshot.data!.id);
                          },
                          child: ListTile(
                            title: Text(
                              snapshot.data!.username,
                              style: TextStyle(
                                  fontWeight:
                                  FontWeight.bold),
                            ),
                            subtitle: Text(
                                snapshot.data!.organization),
                            leading: CircleAvatar(
                                radius: 25,
                                backgroundImage: NetworkImage(
                                  (snapshot.data!.profilePicture == null ||
                                      snapshot.data!.profilePicture == "")
                                      ? "https://ceblog.s3.amazonaws.com/wp-content/uploads/2018/08/20142340/best-homepage-9.png"
                                      : '${Config.apiURL}/${snapshot.data!.profilePicture.toString()}',
                                )
                            ),
                            trailing: TextButton(
                              onPressed: () {},
                              child: Text('unfollow'),
                            ),
                          ),
                        );
                      } else return CircularProgressIndicator();
                    },
                  );
                }),
          );
        } else return CircularProgressIndicator();
      },
    );
  }

  Widget following(int follow) {
    return FutureBuilder<UserModel>(
      future: futureFriend,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          if(follow == 0){
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(20.0),
              ),
              clipBehavior: Clip.antiAlias,
              child: ListView(
                shrinkWrap: true,
                children: [
                  ListTile(
                    title: Center(child: Text('Following no one')),
                  )
                ],
              ),
            );
          }
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(20.0),
            ),
            clipBehavior: Clip.antiAlias,
            child: ListView.builder(
                physics:
                NeverScrollableScrollPhysics(),
                itemCount:
                follow,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return FutureBuilder<UserModel>(
                    future: APIService().fetchAnyUser(snapshot.data!.following[index]),
                    builder: (context, snapshot){
                      if(snapshot.hasData){
                        return InkWell(
                          onTap: (){
                            Navigator.pushNamed(context, '/friendprofile',
                                arguments: snapshot.data!.id);
                          },
                          child: ListTile(
                            title: Text(
                              snapshot.data!.username,
                              style: TextStyle(
                                  fontWeight:
                                  FontWeight.bold),
                            ),
                            subtitle: Text(
                                snapshot.data!.organization),
                            leading: CircleAvatar(
                                radius: 25,
                                backgroundImage: NetworkImage(
                                  (snapshot.data!.profilePicture == null ||
                                      snapshot.data!.profilePicture == "")
                                      ? "https://ceblog.s3.amazonaws.com/wp-content/uploads/2018/08/20142340/best-homepage-9.png"
                                      : '${Config.apiURL}/${snapshot.data!.profilePicture.toString()}',
                                )
                            ),
                            trailing: TextButton(
                              onPressed: () {},
                              child: Text('unfollow'),
                            ),
                          ),
                        );
                      } else return CircularProgressIndicator();
                    },
                  );
                }),
          );
        } else return CircularProgressIndicator();
      },
    );
  }
}