import 'package:eportfolio/services/api_service.dart';
import 'package:flutter/material.dart';

import '../../models/user_model.dart';

class FriendAboutMeBlock extends StatefulWidget {
  FriendAboutMeBlock({required this.userId});
  String userId;


  @override
  State<FriendAboutMeBlock> createState() => _FriendAboutMeBlockState(userId);
}

class _FriendAboutMeBlockState extends State<FriendAboutMeBlock> {

  late Future<UserModel> futureFriend;
  String userId;

  _FriendAboutMeBlockState(this.userId);

  @override
  void initState() {
    super.initState();
    futureFriend = APIService().fetchAnyUser(userId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel>(
        future: futureFriend,
        builder: (context, snapshot){
          if(snapshot.hasData){
            return Container(
              padding: EdgeInsets.all(8),
              child: Card(
                color: Colors.grey[200],
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'About Me',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 20),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          IconButton(color : Colors.grey[200],onPressed: () {}, icon: Icon(Icons.more_horiz))
                        ],
                      ),
                      Container(
                        child: Column(
                          children: <Widget>[
                            Align(
                              child: Container(
                                  padding:
                                  EdgeInsets.only(right: 12, left: 10, top: 10, bottom: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    //crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          snapshot.data!.about ?? '',
                                          style: TextStyle(
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else{
            return CircularProgressIndicator();
          }
        }
    );
  }
}
