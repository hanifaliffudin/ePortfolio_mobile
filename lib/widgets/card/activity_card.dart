import 'package:flutter/material.dart';
import '../../models/activity_model.dart';
import '../../models/user_model.dart';
import '../../services/api_service.dart';


class ActivityCard extends StatefulWidget {
  const ActivityCard({Key? key}) : super(key: key);

  @override
  State<ActivityCard> createState() => _ActivityCardState();
}

class _ActivityCardState extends State<ActivityCard> {

  late Future<List<ActivityModel>> futureActivity;

  @override
  void initState(){
    super.initState();
    futureActivity = APIService().fetchAnyActivity();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ActivityModel>>(
      future: futureActivity,
      builder: (context, snapshot){
        if(snapshot.hasData){
          return ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: snapshot.data!.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Container(
                  child: InkWell(
                    onTap: (){
                      //Navigator.push(context, MaterialPageRoute(builder: (context)=>CertCardOpen()));
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: NetworkImage(('https://picsum.photos/300')),
                                      radius: 25,
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(snapshot.data![index].title,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.blue,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text('public',
                                              style: TextStyle(
                                                color: Colors.grey[400],
                                              ),),
                                            SizedBox(width: 5,),
                                            Text(snapshot.data![index].type,
                                              style: TextStyle(
                                                color: Colors.grey[400],
                                              ),),
                                          ],
                                        ),

                                      ],
                                    ),
                                    SizedBox(width: 8,),
                                  ],
                                ),
                                IconButton(
                                    onPressed: (){},
                                    icon: Icon(Icons.more_horiz)
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 8),
                              child :Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                    snapshot.data![index].desc
                                ),
                              ),
                            ),
                            SizedBox(height: 10,),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Start : ${snapshot.data![index].startDate}',
                                style: TextStyle(
                                    color: Colors.grey
                                ),
                              ),
                            ),
                            SizedBox(width: 20,),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text('Updated on 24 May 2022',
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
          );
        } else return CircularProgressIndicator();
      }
    );
  }
}
