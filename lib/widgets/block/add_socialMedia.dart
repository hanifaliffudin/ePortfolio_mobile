import 'package:eportfolio/widgets/block/custom_block.dart';
import 'package:eportfolio/widgets/custom_appBar.dart';
import 'package:flutter/material.dart';

class AddSocialMedia extends StatefulWidget {
  const AddSocialMedia({Key? key}) : super(key: key);

  @override
  State<AddSocialMedia> createState() => _AddSocialMediaState();
}

class _AddSocialMediaState extends State<AddSocialMedia> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: CustomBlock(hintText: 'Social Media', descriptionText: 'Add social media'),
    );
  }
}
