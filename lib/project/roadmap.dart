import 'package:eportfolio/project/add_roadmap.dart';
import 'package:eportfolio/project/edit_roadmap.dart';
import 'package:eportfolio/project/tasks_project.dart';
import 'package:eportfolio/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import '../config.dart';
import '../models/project_model.dart';
import '../models/user_model.dart';

class Roadmap extends StatefulWidget {
  Roadmap({Key? key, required this.projectId}) : super(key: key);
  String projectId;

  @override
  State<Roadmap> createState() => _RoadmapState(projectId);
}

class _RoadmapState extends State<Roadmap> {
  String projectId;

  _RoadmapState(this.projectId);

  late Future<ProjectModel> futureProject;
  late Future<UserModel> futureUser;

  @override
  void initState() {
    super.initState();
    futureProject = APIService().fetchSingleProject(projectId);
    futureUser = APIService().fetchAnyUser();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ProjectModel>(
      future: futureProject,
      builder: (context, snapshoty) {
        if (snapshoty.hasData) {
          return Scaffold(
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 200.0,
                  floating: true,
                  pinned: true,
                  snap: true,
                  actionsIconTheme: IconThemeData(opacity: 0.0),
                  flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      title: Text(snapshoty.data!.title,
                          style: TextStyle(
                            color: Colors.white,
                            backgroundColor: Colors.black38,
                            fontSize: 16.0,
                          )),
                      background: Image.network(
                        snapshoty.data!.image,
                        fit: BoxFit.cover,
                      )),
                ),
                SliverFillRemaining(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Card(
                          color: Colors.grey[200],
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: const [
                                            Text(
                                              'Project Information',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    IconButton(
                                        color: Colors.grey[200],
                                        onPressed: () {},
                                        icon: Icon(Icons.more_horiz))
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  child: Column(
                                    children: <Widget>[
                                      Align(
                                        child: Container(
                                            padding: EdgeInsets.only(
                                                right: 10,
                                                left: 10,
                                                top: 10,
                                                bottom: 10),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Project type : ${snapshoty.data!.type}',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 15),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                          'During : ${snapshoty.data!.startDate != null ? DateFormat.yMMMEd().format(DateTime.parse(snapshoty.data!.startDate)) : ''}',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 15)),
                                                      Text(
                                                          ' - ${snapshoty.data!.endDate != null ? DateFormat.yMMMEd().format(DateTime.parse(snapshoty.data!.endDate)) : 'now'}',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 15))
                                                    ],
                                                  ),
                                                  Text(
                                                      'Created at : ${snapshoty.data!.createdAt != null ? DateFormat.yMMMEd().format(DateTime.parse(snapshoty.data!.createdAt)) : ''}',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 15)),
                                                ],
                                              ),
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Description',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17),
                                    ),
                                    TextButton(
                                        onPressed: () async {
                                          await showDialog(
                                              context: context,
                                              builder: (_) => participant(
                                                  snapshoty.data!.participants
                                                      .length,
                                                  snapshoty.data!.participants,
                                                  snapshoty.data!.userId));
                                        },
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStatePropertyAll<Color>(
                                                  Colors.blue),
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                          ),
                                        ),
                                        child: Text(
                                          'See participant',
                                          style: TextStyle(color: Colors.white),
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  child: Column(
                                    children: <Widget>[
                                      Align(
                                        child: Container(
                                            padding: EdgeInsets.only(
                                                right: 10,
                                                left: 10,
                                                top: 10,
                                                bottom: 10),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    snapshoty.data!.desc,
                                                    maxLines: 7,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 15),
                                                  ),
                                                ],
                                              ),
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: const [
                                            Text(
                                              'Roadmaps :',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    IconButton(
                                        color: Colors.grey[200],
                                        onPressed: () {},
                                        icon: Icon(Icons.more_horiz))
                                  ],
                                ),
                                Container(
                                  height: 200,
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: snapshoty.data!.roadmaps.isEmpty
                                        ? Card(
                                            child: Container(
                                              width: 200,
                                              height: 200,
                                              margin: EdgeInsets.all(8),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  SizedBox(
                                                    height: 70,
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Center(
                                                      child: Text(
                                                        'NO ROADMAP YET',
                                                        maxLines: 6,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.black38),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        : ListView.builder(
                                            itemCount:
                                                snapshoty.data!.roadmaps.length,
                                            scrollDirection: Axis.horizontal,
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              snapshoty.data!.roadmaps.sort(
                                                  (b, a) => a.startDate
                                                      .compareTo(b.startDate));
                                              return InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              TasksProject(
                                                                  dataRoadmap: snapshoty
                                                                          .data!
                                                                          .roadmaps[
                                                                      index],
                                                                  dataProject:
                                                                      snapshoty
                                                                          .data!)));
                                                },
                                                child: Card(
                                                  child: Container(
                                                    width: 200,
                                                    margin: EdgeInsets.all(8),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Container(
                                                                margin:
                                                                    EdgeInsets
                                                                        .all(
                                                                            10),
                                                                child:
                                                                    Container(
                                                                  width: 120,
                                                                  child: Text(
                                                                    snapshoty
                                                                        .data!
                                                                        .roadmaps[
                                                                            index]
                                                                        .title,
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                  ),
                                                                )),
                                                            IconButton(
                                                                onPressed: () {
                                                                  showModalBottomSheet(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) =>
                                                                              Container(
                                                                                height: 100,
                                                                                margin: EdgeInsets.only(left: 10, top: 10, right: 10),
                                                                                child: Column(
                                                                                  children: [
                                                                                    ElevatedButton(
                                                                                        style: ElevatedButton.styleFrom(),
                                                                                        onPressed: () {
                                                                                          snapshoty.data!.roadmaps.removeWhere((element) => element.title == snapshoty.data!.roadmaps[index].title);
                                                                                          APIService().updateProjectRoadmap(snapshoty.data!.roadmaps, snapshoty.data!.id).then((response) => {
                                                                                                if (response)
                                                                                                  {
                                                                                                    FormHelper.showSimpleAlertDialog(
                                                                                                      context,
                                                                                                      "Deleted!",
                                                                                                      "Roadmap deleted!",
                                                                                                      "OK",
                                                                                                      () {
                                                                                                        Navigator.of(context).pop();
                                                                                                        setState(() {
                                                                                                          futureProject = APIService().fetchSingleProject(projectId);
                                                                                                          futureUser = APIService().fetchAnyUser();
                                                                                                        });
                                                                                                      },
                                                                                                    )
                                                                                                  }
                                                                                                else
                                                                                                  {
                                                                                                    FormHelper.showSimpleAlertDialog(
                                                                                                      context,
                                                                                                      "Error!",
                                                                                                      "Delete Roadmap Error! Please try again",
                                                                                                      "OK",
                                                                                                      () {
                                                                                                        Navigator.of(context).pop();
                                                                                                      },
                                                                                                    )
                                                                                                  }
                                                                                              });
                                                                                        },
                                                                                        child: Row(
                                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                          children: [
                                                                                            Text('Delete'),
                                                                                            Icon(Icons.delete)
                                                                                          ],
                                                                                        )),
                                                                                    ElevatedButton(
                                                                                        style: ElevatedButton.styleFrom(),
                                                                                        onPressed: () {
                                                                                          Navigator.push(
                                                                                            context,
                                                                                            MaterialPageRoute(
                                                                                                builder: (context) => EditRoadmap(
                                                                                                      projectData: snapshoty.data!,
                                                                                                      roadmapData: snapshoty.data!.roadmaps[index],
                                                                                                    )),
                                                                                          );
                                                                                        },
                                                                                        child: Row(
                                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                          children: [
                                                                                            Text('Edit'),
                                                                                            Icon(Icons.edit)
                                                                                          ],
                                                                                        )),
                                                                                  ],
                                                                                ),
                                                                              ));
                                                                },
                                                                icon: Icon(Icons
                                                                    .more_horiz)),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Align(
                                                          //desc
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: Container(
                                                              margin: EdgeInsets
                                                                  .all(10),
                                                              child: Text(
                                                                snapshoty
                                                                    .data!
                                                                    .roadmaps[
                                                                        index]
                                                                    .desc,
                                                                maxLines: 6,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              )),
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          AddRoadmap(projectData: snapshoty.data!)),
                );
              },
            ),
          );
        } else
          return CircularProgressIndicator();
      },
    );
  }

  Widget participant(int participant, List participation, String owner) {
    return FutureBuilder<UserModel>(
      future: futureUser,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              clipBehavior: Clip.antiAlias,
              child: ListView(
                shrinkWrap: true,
                children: [
                  FutureBuilder<UserModel>(
                    future: APIService().fetchAnyUser(owner),
                    builder: (context, snap) {
                      if (snap.hasData) {
                        return ListTile(
                          title: Text(snap.data!.username,  style: const TextStyle(
                              fontWeight: FontWeight.bold),),
                          subtitle: Text('Owner'),
                          leading: CircleAvatar(
                              radius: 25,
                              backgroundImage: NetworkImage(
                                (snapshot.data!.profilePicture == null ||
                                        snapshot.data!.profilePicture == "")
                                    ? "https://ceblog.s3.amazonaws.com/wp-content/uploads/2018/08/20142340/best-homepage-9.png"
                                    : '${Config.apiURL}/${snap.data!.profilePicture.toString()}',
                              )),
                        );
                      } else
                        return Center(child: CircularProgressIndicator());
                    },
                  ),
                  Container(
                    child: participant != 0
                        ? ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: participant,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return FutureBuilder<UserModel>(
                                future: APIService()
                                    .fetchAnyUser(participation[index]),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return ListTile(
                                      title: Text(
                                        snapshot.data!.username,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle:
                                          Text('Participant'),
                                      leading: CircleAvatar(
                                          radius: 25,
                                          backgroundImage: NetworkImage(
                                            (snapshot.data!.profilePicture ==
                                                        null ||
                                                    snapshot.data!
                                                            .profilePicture ==
                                                        "")
                                                ? "https://ceblog.s3.amazonaws.com/wp-content/uploads/2018/08/20142340/best-homepage-9.png"
                                                : '${Config.apiURL}/${snapshot.data!.profilePicture.toString()}',
                                          )),
                                    );
                                  } else
                                    return CircularProgressIndicator();
                                },
                              );
                            })
                        : ListTile(
                            title: Center(child: Text('No Participant Yet')),
                          ),
                  )
                ],
              ),
            );
        } else
          return CircularProgressIndicator();
      },
    );
  }
}
