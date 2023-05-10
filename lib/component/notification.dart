import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import '../config.dart';
import '../models/user_model.dart';
import '../project/notification_model.dart';
import '../project/roadmap.dart';
import '../services/api_service.dart';

class Nofitication extends StatefulWidget {
  const Nofitication({Key? key}) : super(key: key);

  @override
  State<Nofitication> createState() => _NofiticationState();
}

class _NofiticationState extends State<Nofitication> {
  bool isApiCallProcess = false;
  late Future<List<Notify>> futureNotify;
  late Future<UserModel> futureUser;

 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureNotify = APIService().fetchRequestedProject();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification'),
      ),
      body: ProgressHUD(
        inAsyncCall: isApiCallProcess,
        opacity: 0.3,
        key: UniqueKey(),
        child: FutureBuilder<List<Notify>>(
          future: futureNotify,
          builder: (BuildContext context, AsyncSnapshot<List<Notify>?> snapshoty) {
            if (snapshoty.hasData) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshoty.data!.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  child: Column(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              'New request for project participation from : ',
                                              style: TextStyle(
                                                  fontSize: 12,)
                                            )),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      FutureBuilder<UserModel>(
                                        future: APIService().fetchAnyUser(snapshoty.data![index].userId),
                                        builder: (context, snapshot){
                                          if(snapshot.hasData){
                                            return Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.pushNamed(context, '/friendprofile',
                                                        arguments: snapshoty.data![index].userId);
                                                  },
                                                  child: CircleAvatar(
                                                    radius: 25,
                                                    backgroundImage: NetworkImage(
                                                      (snapshot.data!.profilePicture ==
                                                          "")
                                                          ? "https://ceblog.s3.amazonaws.com/wp-content/uploads/2018/08/20142340/best-homepage-9.png"
                                                          : '${Config.apiURL}/${snapshot.data!.profilePicture.toString()}',
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 8,
                                                ),
                                                InkWell(
                                                  onTap:(){
                                                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Roadmap(projectId: snapshoty.data![index].projectId)));
                                                  },
                                                  child: Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      SizedBox(
                                                        height: 8,
                                                      ),
                                                      Container(
                                                        width: 150,
                                                        child: Text(
                                                          snapshot.data!.username,
                                                          overflow: TextOverflow.ellipsis,
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                              FontWeight.bold),
                                                        ),
                                                      ),
                                                      Text(
                                                        snapshot.data!.organization,
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.w500),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  children: [
                                                    TextButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            isApiCallProcess = true;
                                                          });
                                                          APIService().acceptProjectParticipant(snapshoty.data![index].projectId, snapshoty.data![index].userId).then((response) {
                                                            if (response) {
                                                              setState(() {
                                                                futureNotify = APIService().fetchRequestedProject();
                                                                isApiCallProcess = false;
                                                              });
                                                            } else {
                                                              FormHelper.showSimpleAlertDialog(
                                                                context,
                                                                "Error!",
                                                                "Failed added to participant! Please try again",
                                                                "OK",
                                                                    () {
                                                                  Navigator.of(context).pop();
                                                                },
                                                              );
                                                            }
                                                          });
                                                        },
                                                        style: ButtonStyle(
                                                          backgroundColor:
                                                          MaterialStatePropertyAll<
                                                              Color>(Colors.green),
                                                          shape:
                                                          MaterialStateProperty.all<
                                                              RoundedRectangleBorder>(
                                                            RoundedRectangleBorder(
                                                              borderRadius:
                                                              BorderRadius.circular(
                                                                  10.0),
                                                            ),
                                                          ),
                                                        ),
                                                        child: Text('Accept',
                                                            style: TextStyle(
                                                                color: Colors.white))),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    TextButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            isApiCallProcess = true;
                                                          });
                                                          APIService().declineProjectParticipant(snapshoty.data![index].projectId, snapshoty.data![index].userId).then((response) {
                                                            if (response) {
                                                              setState(() {
                                                                futureNotify = APIService().fetchRequestedProject();
                                                                isApiCallProcess = false;
                                                              });
                                                            } else {
                                                              FormHelper.showSimpleAlertDialog(
                                                                context,
                                                                "Error!",
                                                                "Failed decline to participant! Please try again",
                                                                "OK",
                                                                    () {
                                                                  Navigator.of(context).pop();
                                                                },
                                                              );
                                                            }
                                                          });
                                                        },
                                                        style: ButtonStyle(
                                                          backgroundColor:
                                                          MaterialStatePropertyAll<
                                                              Color>(Colors.red),
                                                          shape:
                                                          MaterialStateProperty.all<
                                                              RoundedRectangleBorder>(
                                                            RoundedRectangleBorder(
                                                              borderRadius:
                                                              BorderRadius.circular(
                                                                  10.0),
                                                            ),
                                                          ),
                                                        ),
                                                        child: Text(
                                                          'Decline',
                                                          style: TextStyle(
                                                              color: Colors.white),
                                                        ))
                                                  ],
                                                )
                                              ],
                                            );
                                          }else return CircularProgressIndicator();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ],
                ),
              );
            } else return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
