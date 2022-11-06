import 'package:eportfolio/widgets/block/custom_block.dart';
import 'package:eportfolio/widgets/custom_appBar.dart';
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
      appBar: CustomAppBar(),
      body: Container(
        child: CustomBlock(hintText: 'Skills', descriptionText: 'Write your Skill'),
      )
    );
  }
}
