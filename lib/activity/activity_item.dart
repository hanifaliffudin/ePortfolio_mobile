import 'package:eportfolio/view/home.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import '../models/activity_model.dart';
import '../services/api_service.dart';
import 'activity_task.dart';
import 'add_activity.dart';

class ActivityItem extends StatefulWidget {
  const ActivityItem({Key? key}) : super(key: key);

  @override
  State<ActivityItem> createState() => _ActivityItemState();
}

class _ActivityItemState extends State<ActivityItem> {

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
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> ActivityTask(activityId: snapshot.data![index].id)));
                    },
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
                                            Text(snapshot.data![index].isPublic == true ? 'Public':'Private',
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
                                    onPressed: (){
                                      settingButton(snapshot.data![index].id);
                                    },
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
                    APIService().deleteActivity(id).then((response) {
                      if (response) {
                        FormHelper.showSimpleAlertDialog(
                          context,
                          "Success!",
                          "Success delete activity!",
                          "OK",
                              () {
                            Navigator.pushNamedAndRemoveUntil(
                                context, '/activity', (route) => true);
                          },
                        );
                      } else {
                        FormHelper.showSimpleAlertDialog(
                          context,
                          "Error!",
                          "Failed delete activity! Please try again",
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
                    Navigator.push(context , MaterialPageRoute(builder: (context) => AddActivity(id : id)),
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
