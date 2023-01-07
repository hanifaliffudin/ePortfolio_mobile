import 'package:eportfolio/config.dart';
import 'package:eportfolio/services/api_service.dart';
import 'package:flutter/material.dart';


import '../models/user_model.dart';

class ProfileHeader extends StatefulWidget {
  ProfileHeader({Key? key}) : super(key: key);

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  late Future<UserModel> futureUser;

  @override
  void initState() {
    super.initState();
    futureUser = APIService().fetchAnyUser();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel>(
        future: futureUser,
        builder: (context, snapshot){
          if(snapshot.hasData){
            return Container(
              padding: EdgeInsets.only(left: 20, top: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                (snapshot.data!.profilePicture ==
                                    null ||
                                    snapshot.data!.profilePicture ==
                                        "")
                                    ? "https://ceblog.s3.amazonaws.com/wp-content/uploads/2018/08/20142340/best-homepage-9.png"
                                    : '${Config.apiURL}/${snapshot.data!.profilePicture.toString()}',
                              ), radius: 60,
                            )
                          ),
                          //SizedBox(height: 10,),
                        ],
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(snapshot.data!.username ?? '',
                              style:
                              TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
                      )
                    ],
                  ),
                  SizedBox(
                    height: 130,
                  ),
                  IconButton(onPressed: () {
                    showModalBottomSheet(context: context, builder: (context)=>
                        Container(
                          height: 50,
                          margin: EdgeInsets.only(left: 10, top: 10,right: 10),
                          child: Column(
                            children: [
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                  ),
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/editUser');
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Edit'),
                                      Icon(Icons.edit)
                                    ],
                                  )
                              ),
                            ],
                          ),
                        ));
                  }, icon: Icon(Icons.more_horiz)),
                ],
              ),
            );
          } else {
            return CircularProgressIndicator();
          }
        }
    );
  }
}