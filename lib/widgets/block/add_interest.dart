import 'package:eportfolio/widgets/block/custom_block.dart';
import 'package:eportfolio/widgets/custom_appBar.dart';
import 'package:flutter/material.dart';

class AddInterest extends StatefulWidget {
  const AddInterest({Key? key}) : super(key: key);

  @override
  State<AddInterest> createState() => _AddInterestState();
}

class _AddInterestState extends State<AddInterest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: CustomBlock(hintText: 'Interest', descriptionText: 'Write your interest'),
    );
  }
}
