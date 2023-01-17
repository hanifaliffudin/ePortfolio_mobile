import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/activity_model.dart';
import '../../services/api_service.dart';
import 'activity_task.dart';

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
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const ActivityTask()));
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
                                      backgroundImage: NetworkImage((snapshot.data![index].image)),
                                      radius: 25,
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 240,
                                          child: Text(snapshot.data![index].title, overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              color: Colors.blue,
                                            ),
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
                                    snapshot.data![index].desc,overflow: TextOverflow.ellipsis, maxLines: 3,
                                ),
                              ),
                            ),
                            SizedBox(height: 10,),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'During ${snapshot.data![index].startDate !=null ? DateFormat.yMMMEd().format(DateTime.parse(snapshot.data![index].startDate)) : ''} - ${snapshot.data![index].endDate !=null ? DateFormat.yMMMEd().format(DateTime.parse(snapshot.data![index].endDate)) : ''}',
                                style: TextStyle(
                                    color: Colors.grey
                                ),
                              ),
                            ),
                            SizedBox(width: 20,),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text('Updated on ${snapshot.data![index].updatedAt !=null ? DateFormat.yMMMEd().format(DateTime.parse(snapshot.data![index].updatedAt)) : ''}',
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