import 'package:eportfolio/widgets/block/add_skill.dart';
import 'package:eportfolio/widgets/block/newest_activity.dart';
import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/api_service.dart';
import '../view/friend/friend_about_me_block.dart';
import '../view/friend/friend_personal_information.dart';
import 'block/add_interest.dart';
import 'block/add_socialMedia.dart';

class AboutMeContent extends StatefulWidget {
  const AboutMeContent({Key? key}) : super(key: key);

  @override
  State<AboutMeContent> createState() => _AboutMeContentState();
}

class _AboutMeContentState extends State<AboutMeContent> {

  late Future<UserModel> futureUser;

  @override
  void initState() {
    super.initState();
    futureUser = APIService().fetchAnyUser();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder<UserModel>(
          future: futureUser,
          builder : (context, snapshot){
            if(snapshot.hasData){
              return Column(
                children: [
                  SizedBox(height: 7,),
                  FriendPersonalInformation(userId: snapshot.data!.id),
                  FriendAboutMeBlock(userId : snapshot.data!.id),
                  NewestAct(userId : snapshot.data!.id)
                ],
              );
            } else return CircularProgressIndicator();
          }
        ),
      ],
    );
  }
}



