import 'package:eportfolio/services/api_service.dart';
import 'package:eportfolio/view/add_badges.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../config.dart';
import '../../models/badges_model.dart';

class FriendBadges extends StatefulWidget {
  FriendBadges({Key? key, required this.userId}) : super(key: key);
  String userId;

  @override
  State<FriendBadges> createState() => _FriendBadgesState(userId);
}

class _FriendBadgesState extends State<FriendBadges> {
  late Future<List<BadgesModel>> futureBadges;
  String userId;
  _FriendBadgesState(this.userId);

  @override
  void initState() {
    super.initState();
    futureBadges = APIService().fetchAnyBadges(userId);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.blue,
              minimumSize: const Size.fromHeight(35), // NEW
            ),
            onPressed: () {
              Navigator.push(context , MaterialPageRoute(builder: (context) => const AddBadges()),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Add new Badges',
                  style: TextStyle(fontSize: 15),
                ),
                Icon(Icons.add)
              ],
            ),
          ),
        ),
        FutureBuilder<List<BadgesModel>>(
          future: futureBadges,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 300,
                      childAspectRatio: 1.4 / 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return Container(
                        margin: EdgeInsets.only(left: 10, right: 10),
                        height: 100,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 2,
                                  offset: Offset(0, 2) // Shadow position
                              ),
                            ],
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 8,
                            ),
                            Image.network(
                              '${snapshot.data![index].imgBadge.toString()}',
                              width: 80,
                              height: 80,
                              fit: BoxFit.scaleDown,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Text(
                                snapshot.data![index].title, overflow: TextOverflow.ellipsis, maxLines: 2,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: Text(snapshot.data![index].desc, overflow: TextOverflow.ellipsis, maxLines: 3,)),
                            SizedBox(height: 8,),
                            Container(
                                alignment: Alignment.topLeft,
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: Text('Issuer : ${snapshot.data![index].issuer}', style: TextStyle(
                                    fontWeight: FontWeight.bold
                                ),)),
                            SizedBox(
                              height: 8,
                            ),
                            Container(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: Text('Earned ${snapshot.data![index].earnedDate !=null ? DateFormat.yMMMEd().format(DateTime.parse(snapshot.data![index].earnedDate)) : ''}'))
                          ],
                        ));
                  });
            } else
              return CircularProgressIndicator();
          },
        ),
        SizedBox(
          height: 5,
        ),
      ],
    );
  }
}
