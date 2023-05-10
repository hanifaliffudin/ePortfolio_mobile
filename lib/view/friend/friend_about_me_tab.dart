import 'package:eportfolio/widgets/block/newest_activity.dart';
import 'package:flutter/material.dart';
import 'friend_about_me_block.dart';
import 'friend_personal_information.dart';


class FriendAboutMeContent extends StatefulWidget {
  FriendAboutMeContent({required this.userId});
  String userId;

  @override
  State<FriendAboutMeContent> createState() => _FriendAboutMeContentState(userId);
}

class _FriendAboutMeContentState extends State<FriendAboutMeContent> {
  String userId;
  _FriendAboutMeContentState(this.userId);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 7,),
        FriendPersonalInformation(userId: userId,),
        FriendAboutMeBlock(userId : userId),
        NewestAct(userId : userId)
      ],
    );
  }

}



