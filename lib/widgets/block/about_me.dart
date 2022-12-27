import 'package:eportfolio/models/users_response_model.dart';
import 'package:eportfolio/services/api_service.dart';
import 'package:flutter/material.dart';

class AboutMe extends StatefulWidget {
  const AboutMe({Key? key}) : super(key: key);

  @override
  State<AboutMe> createState() => _AboutMeState();
}

class _AboutMeState extends State<AboutMe> {

  var data;
  String? about;

  Future<Map<String, dynamic>> getUserData() async{
    data = await APIService.getUserData();
    about = data['about'];
    return data;
  }

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getUserData(),
      builder: (context, snapshot){
        if(snapshot.hasData){
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
                                  'About Me',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 20),
                                ),
                              ],
                            ),
                          ],
                        ),
                        IconButton(color : Colors.grey[200],onPressed: () {}, icon: Icon(Icons.more_horiz))
                      ],
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Align(
                            child: Container(
                                padding:
                                EdgeInsets.only(right: 12, left: 10, top: 10, bottom: 10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  //crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        about ?? '',
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else{
          return CircularProgressIndicator();
        }
      }
      );
  }
}
