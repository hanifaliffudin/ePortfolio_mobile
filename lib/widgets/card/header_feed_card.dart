import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../config.dart';
import '../../models/post_model.dart';

class HeaderFeedCard extends StatefulWidget {

  HeaderFeedCard({required this.postData});
  PostModel postData;

  @override
  State<HeaderFeedCard> createState() => _HeaderFeedCardState();
}

class _HeaderFeedCardState extends State<HeaderFeedCard> {

  String? username;
  String? major;
  String? date;

  void getUser() async{
    var url = Config.users;
    await http
          .get(Uri.parse('$url/${widget.postData.userId}'))
          .then((value) {
        var data = json.decode(value.body);
        username = data['username'];
        major = data['major'];
        setState(() {});
      });
    }

  @override
  void initState(){
    super.initState();
    getUser();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const CircleAvatar(
                backgroundImage: NetworkImage(('https://picsum.photos/200')),
                radius: 25,
              ),
              const SizedBox(width: 8,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    username ?? '',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                    ),
                  ),
                  Text(major ?? ''),
                  /*Text(postList[index].updatedAt)*/
                ],
              ),
            ],
          ),
          IconButton(
              onPressed: (){
                settingButton(context);
              },
              icon: Icon(Icons.more_horiz)
          )
        ],
      ),
    );
  }
}

void settingButton(context){
  showModalBottomSheet(context: context, builder: (context)=>
      Container(
        height: 100,
        margin: EdgeInsets.only(left: 10, top: 10,right: 10),
        child: Column(
          children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                ),
                onPressed: () {

                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Edit'),
                    Icon(Icons.edit)
                  ],
                )
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                ),
                onPressed: () {

                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Delete'),
                    Icon(Icons.remove)
                  ],
                )
            ),
          ],
        ),
      ));
}
