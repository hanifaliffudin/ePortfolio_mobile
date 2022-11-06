import 'package:eportfolio/widgets/block/about_me.dart';
import 'package:eportfolio/widgets/block/add_skill.dart';
import 'package:eportfolio/widgets/box_add_post.dart';
import 'package:eportfolio/widgets/block/newest_activity.dart';
import 'package:eportfolio/widgets/block/personal_information_block.dart';
import 'package:flutter/material.dart';

class AboutMeContent extends StatefulWidget {
  const AboutMeContent({Key? key}) : super(key: key);

  @override
  State<AboutMeContent> createState() => _AboutMeContentState();
}

class _AboutMeContentState extends State<AboutMeContent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 7,),
        Container(
          padding: EdgeInsets.only(left: 10),
          child: Align(
            alignment: Alignment.topLeft,
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(Colors.blue),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              onPressed: () {
                AddBlock(context);
              },
              child: Text(
                'Add new block',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        PersonalInformation(),
        AboutMe(),
        NewestAct()

      ],
    );
  }
}
void AddBlock(context){
  showModalBottomSheet(context: context, builder: (context)=>
      Container(
        height: 200,
        margin: EdgeInsets.only(left: 10, top: 10,right: 10),
        child: Column(
          children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>AddSkill()));
                },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Add Skill Block'),
                  Icon(Icons.add)
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
                    Text('Add Interest Block'),
                    Icon(Icons.add)
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
                    Text('Add Social Media Block'),
                    Icon(Icons.add)
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
                    Text('Add Custom Block'),
                    Icon(Icons.add)
                  ],
                )
            ),
          ],
        ),
  ));
}


