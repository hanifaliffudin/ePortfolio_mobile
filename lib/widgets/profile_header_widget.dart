import 'package:eportfolio/config.dart';
import 'package:eportfolio/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

import '../models/project_model.dart';
import '../models/user_model.dart';

class ProfileHeader extends StatefulWidget {
  ProfileHeader({Key? key}) : super(key: key);

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  late Future<UserModel> futureUser;
  late Future<List<ProjectModel>> futureProject;

  @override
  void initState() {
    super.initState();
    futureUser = APIService().fetchAnyUser();
    futureProject = APIService().fetchAnyProject();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel>(
        future: futureUser,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children:
              [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
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
                                    (snapshot.data!.profilePicture == null ||
                                            snapshot.data!.profilePicture == "")
                                        ? "https://ceblog.s3.amazonaws.com/wp-content/uploads/2018/08/20142340/best-homepage-9.png"
                                        : '${Config.apiURL}/${snapshot.data!.profilePicture.toString()}',
                                  ),
                                  radius: 60,
                                )),
                            //SizedBox(height: 10,),
                          ],
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Container(
                          width: 180,
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
                      ],
                    ),
                    SizedBox(
                      height: 130,
                    ),
                    IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) => Container(
                                    height: 50,
                                    margin: EdgeInsets.only(
                                        left: 10, top: 10, right: 10),
                                    child: Column(
                                      children: [
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(),
                                            onPressed: () {
                                              Navigator.pushNamed(
                                                  context, '/editUser');
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text('Edit'),
                                                Icon(Icons.edit)
                                              ],
                                            )),
                                      ],
                                    ),
                                  ));
                        },
                        icon: Icon(Icons.more_horiz)),
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    FutureBuilder<List<ProjectModel>>(
                      future: futureProject,
                      builder: (context, snapshot){
                        if(snapshot.hasData){
                          return InkWell(
                            onTap: (){
                              DefaultTabController.of(context)?.index =6;
                            },
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
              ],
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }

  Widget follower(int follow) {
    return FutureBuilder<UserModel>(
        future: futureUser,
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
                  itemCount:
                  follow,
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
      future: futureUser,
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
