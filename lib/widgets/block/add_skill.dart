import 'package:eportfolio/widgets/block/custom_block.dart';
import 'package:flutter/material.dart';

class AddSkill extends StatefulWidget {
  const AddSkill({Key? key}) : super(key: key);

  @override
  State<AddSkill> createState() => _AddSkillState();
}

class _AddSkillState extends State<AddSkill> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: (){},
              icon: Icon(Icons.logout)
          )
        ],
        centerTitle: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('FILKOM'),
            Text(
              'Student Dashboard',
              style: TextStyle(
                  fontSize: 16
              ),
            ),
          ],
        ),
      ),
      body: Container(
        child: CustomBlock(hintText: 'Skills', descriptionText: 'Write your Skill'),
      )
    );
  }
}
