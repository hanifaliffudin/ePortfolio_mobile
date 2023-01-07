import 'package:eportfolio/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'config.dart';
import 'models/badges_model.dart';

class Badges extends StatefulWidget {
  const Badges({Key? key}) : super(key: key);

  @override
  State<Badges> createState() => _BadgesState();
}

class _BadgesState extends State<Badges> {
  late Future<List<BadgesModel>> futureBadges;

  @override
  void initState() {
    super.initState();
    futureBadges = APIService().fetchAnyBadges();
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
              /*Navigator.push(context , MaterialPageRoute(builder: (context) => const AddCollection()),
              );*/
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
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 1.5 / 2,
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
                              '${Config.apiURL}${snapshot.data![index].imgBadge.toString()}',
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
                                snapshot.data![index].title,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 10, right: 10),
                                child: Text(snapshot.data![index].desc)),
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
                                child: Text(snapshot.data![index].earnedDate))
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
