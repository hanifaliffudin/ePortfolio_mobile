import 'package:eportfolio/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/user_model.dart';


class FriendPersonalInformation extends StatefulWidget {
  FriendPersonalInformation({required this.userId});
  String userId;

  @override
  State<FriendPersonalInformation> createState() => _FriendPersonalInformationState(userId);
}

class _FriendPersonalInformationState extends State<FriendPersonalInformation> {

  String userId;
  late Future<UserModel> futureFriend;

  _FriendPersonalInformationState(this.userId);

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
                                    'Personal Information',
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
                                  padding: EdgeInsets.only(
                                      right: 10, left: 10, top: 10, bottom: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Name : ${snapshot.data!.username}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                                        Text('Organization : ${snapshot.data!.organization}',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                                        Text('Student ID : ${snapshot.data!.nim}',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                                        Text('Major : ${snapshot.data!.major}',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                                        Text('City : ${snapshot.data!.city}',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                                        Text('Date of Birth : ${snapshot.data!.dateBirth !=null ? DateFormat.yMMMEd().format(DateTime.parse(snapshot.data!.dateBirth)) : ''}',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                                        Text('Gender : ${snapshot.data!.gender !=null ? snapshot.data!.gender : ''}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                                      ],
                                    ),
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
          } else {
            return CircularProgressIndicator();
          }
        }
    );
  }
}
