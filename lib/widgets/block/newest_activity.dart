import 'package:eportfolio/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/activity_model.dart';
import '../card/activity_task.dart';

class NewestAct extends StatefulWidget {
  const NewestAct({Key? key}) : super(key: key);

  @override
  State<NewestAct> createState() => _NewestActState();
}

class _NewestActState extends State<NewestAct> {
  late Future<ActivityModel> futureActivity;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureActivity = APIService().fetchLastActivity();
  }

  @override
  Widget build(BuildContext context) {
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
                            'Newest Activity',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ],
                      ),
                    ],
                  ),

                ],
              ),
              SizedBox(height: 10,),
              FutureBuilder<ActivityModel>(
                future: futureActivity,
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    return Container(
                      child: Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
                                        backgroundImage: NetworkImage((snapshot.data!.image)),
                                        radius: 25,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 240,
                                            child: Text(snapshot.data!.title, overflow: TextOverflow.ellipsis,
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
                                              Text(snapshot.data!.type,
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
                                    snapshot.data!.desc,overflow: TextOverflow.ellipsis, maxLines: 3,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10,),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'During ${snapshot.data!.startDate !=null ? DateFormat.yMMMEd().format(DateTime.parse(snapshot.data!.startDate)) : ''} - ${snapshot.data!.endDate !=null ? DateFormat.yMMMEd().format(DateTime.parse(snapshot.data!.endDate)) : ''}',
                                  style: TextStyle(
                                    fontSize: 12,
                                      color: Colors.grey,
                                  ),
                                ),
                              ),
                              SizedBox(width: 20,),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text('Updated on ${snapshot.data!.updatedAt !=null ? DateFormat.yMMMEd().format(DateTime.parse(snapshot.data!.updatedAt)) : ''}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }else return CircularProgressIndicator();
                },
              ),
              Divider(
                thickness: 1,
                color: Colors.black,
              ),
              InkWell(
                onTap: () {DefaultTabController.of(context)?.index =3;},
                child: Text('Show all activities ->',
                style: TextStyle(
                  fontSize: 15
                ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }


}
