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
                                      right: 120, left: 10, top: 10, bottom: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        RichText(
                                            text: TextSpan(
                                              style: DefaultTextStyle.of(context).style,
                                              children: [
                                                TextSpan(
                                                  text: 'Name : ',
                                                  style:
                                                  TextStyle(fontWeight: FontWeight.bold),
                                                ),
                                                //TextSpan(text: username ?? ''),
                                                TextSpan(text: snapshot.data!.username ?? '',),
                                              ],
                                            )),
                                        RichText(
                                            text: TextSpan(
                                              style: DefaultTextStyle.of(context).style,
                                              children: [
                                                TextSpan(
                                                    text: 'Student ID : ',
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold)),
                                                TextSpan(text: snapshot.data!.nim ?? ''),
                                              ],
                                            )),
                                        RichText(
                                            text: TextSpan(
                                              style: DefaultTextStyle.of(context).style,
                                              children: [
                                                TextSpan(
                                                    text: 'Major : ',
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold)),
                                                TextSpan(text: snapshot.data!.major ?? ''),
                                              ],
                                            )),
                                        RichText(
                                            text: TextSpan(
                                              style: DefaultTextStyle.of(context).style,
                                              children: [
                                                TextSpan(
                                                    text: 'City : ',
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold)),
                                                TextSpan(text: snapshot.data!.city ?? ''),
                                              ],
                                            )),
                                        RichText(
                                            text: TextSpan(
                                              style: DefaultTextStyle.of(context).style,
                                              children: [
                                                TextSpan(
                                                    text: 'Date of Birth : ',
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold)),
                                                TextSpan(text: snapshot.data!.dateBirth !=null ? DateFormat.yMMMEd().format(DateTime.parse(snapshot.data!.dateBirth)) : ''),
                                              ],
                                            )),
                                        RichText(
                                            text: TextSpan(
                                              style: DefaultTextStyle.of(context).style,
                                              children: [
                                                TextSpan(
                                                    text: 'Gender : ',
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold)),
                                                TextSpan(text: snapshot.data!.gender ?? ''),
                                              ],
                                            )),
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
