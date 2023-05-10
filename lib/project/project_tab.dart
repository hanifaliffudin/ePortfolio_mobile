import 'package:eportfolio/project/roadmap.dart';
import 'package:eportfolio/services/api_service.dart';
import 'package:eportfolio/project/add_project.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

import '../models/project_model.dart';
import '../view/home.dart';

class Projects extends StatefulWidget {
  const Projects({Key? key}) : super(key: key);

  @override
  State<Projects> createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> {
  late Future<List<ProjectModel>> futureProject;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureProject = APIService().fetchAnyProject();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: 5, right: 5, top: 10),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.blue,
              minimumSize: const Size.fromHeight(35), // NEW
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> AddProject()));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Add new Project',
                  style: TextStyle(fontSize: 15),
                ),
                Icon(Icons.add)
              ],
            ),
          ),
        ),
        FutureBuilder<List<ProjectModel>>(
          future: futureProject,
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
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> Roadmap(projectId: snapshot.data![index].id)));
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
                                          backgroundImage: NetworkImage(snapshot.data![index].image != null ? snapshot.data![index].image : 'https://fastly.picsum.photos/id/28/4928/3264.jpg?hmac=GnYF-RnBUg44PFfU5pcw_Qs0ReOyStdnZ8MtQWJqTfA'),
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
                                SizedBox(height: 5,),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text('Participant(s) ${snapshot.data![index].participants.length}',
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
          },
        )
      ],
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
                    APIService().deleteProject(id).then((response) {
                      if (response) {
                        FormHelper.showSimpleAlertDialog(
                          context,
                          "Success!",
                          "Success delete project!",
                          "OK",
                              () {
                                Navigator.push(context , MaterialPageRoute(builder: (context) => HomePage(2)));
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
                    Navigator.push(context , MaterialPageRoute(builder: (context) => AddProject(idProject : id)),
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
