import 'package:flutter/material.dart';

class CustomBlock extends StatelessWidget {
  final String hintText;
  final String descriptionText;

  CustomBlock({Key? key,
    required this.hintText,
    required this.descriptionText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Color(0xFFF6F6F6),
          ),
          child: Column(
            children: [
              Align(
                  alignment : Alignment.topLeft,
                  child: Text('$hintText', style: TextStyle(
                    fontSize: 20
                  ),)),
              SizedBox(height: 10,),
              TextField(
                keyboardType: TextInputType.multiline,
                maxLines: 5,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: descriptionText,
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.blue
                  ),
                  onPressed: () {},
                  child: Text(
                    'Add',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

      ],
    );
  }
}
