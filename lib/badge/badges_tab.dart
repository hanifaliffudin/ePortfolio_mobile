import 'package:eportfolio/services/api_service.dart';
import 'package:eportfolio/badge/add_badges.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import '../config.dart';
import '../models/badges_model.dart';

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
              Navigator.push(context , MaterialPageRoute(builder: (context) => AddBadges()),
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
                    return InkWell(
                      onTap: () async {
                        await showDialog(
                            context: context,
                            builder: (_) => badgesDialog(
                                snapshot.data![index].title,
                                snapshot.data![index].desc,
                                snapshot.data![index].imgBadge,
                                snapshot.data![index].issuer,
                                snapshot.data![index].url,
                                snapshot.data![index].earnedDate,
                                snapshot.data![index].skills,
                                snapshot.data![index].id,
                            ));
                      },
                      child: Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          height: 120,
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
                                height: 5,
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
                                  child: Text('Earned : ${snapshot.data![index].earnedDate !=null ? DateFormat.yMMMEd().format(DateTime.parse(snapshot.data![index].earnedDate)) : ''}'))
                            ],
                          )),
                    );
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

  Widget badgesDialog(String title, String desc, String imageNetwork, String issuer, String learnmore, String earndate, List<String> skills, String id) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      clipBehavior: Clip.antiAlias,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Image.network(
                        '${imageNetwork}',
                        fit: BoxFit.contain,
                        width: 230,
                        height: 175,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                     settingButton(id);
                    },
                    icon: Icon(Icons.more_horiz),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Container(
                      width: 300,
                      child: Text(
                        '${title}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      width: 300,
                      child: Text('${desc}',
                          style:
                          TextStyle(fontSize: 18,)),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      width: 300,
                      child: Text('Issuer : ${issuer}',
                          style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Container(
                      width: 300,
                      child: Text('Earned : ${DateFormat.yMMMEd().format(DateTime.parse(earndate))}',
                          style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        height: 35,
                        child: ListView.builder(
                            itemCount: skills.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index){
                              return Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text(skills[index], style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18
                                    ),),
                                  ), /*Icon(Icons.notifications_rounded, color: Colors.black)*/
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1,
                                      color: Colors.black12,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(
                                        10,
                                      ),
                                    ),
                                    color: Colors.black12,
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Container(
                      width: 300,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Learn more : ',  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                          Container(
                            width: 176,
                              child: Text(learnmore != null ? learnmore : '', style: TextStyle(fontSize: 15))),
                        ],
                      )
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void settingButton(String id) {
    showModalBottomSheet(
        context: context,
        builder: (context) => Container(
          height: 100,
          margin: EdgeInsets.only(left: 10, top: 10, right: 10),
          child: Column(
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(),
                  onPressed: () {
                    APIService().deleteBadge(id).then((response) {
                      if (response) {
                        FormHelper.showSimpleAlertDialog(
                          context,
                          "Success!",
                          "Success delete badge!",
                          "OK",
                              () {
                            Navigator.pushNamedAndRemoveUntil(
                                context, '/badge', (route) => false);
                          },
                        );
                      } else {
                        FormHelper.showSimpleAlertDialog(
                          context,
                          "Error!",
                          "Failed delete badge! Please try again",
                          "OK",
                              () {
                            Navigator.of(context).pop();
                          },
                        );
                      }
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('Delete'), Icon(Icons.delete)],
                  )),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(),
                  onPressed: () {
                    Navigator.push(context , MaterialPageRoute(builder: (context) => AddBadges(id : id)),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('Edit'), Icon(Icons.edit)],
                  )),
            ],
          ),
        ));
  }
}
