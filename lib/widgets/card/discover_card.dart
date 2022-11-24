import 'package:flutter/material.dart';

class DiscoverCard extends StatefulWidget {
  const DiscoverCard({Key? key}) : super(key: key);

  @override
  State<DiscoverCard> createState() => _DiscoverCardState();
}

class _DiscoverCardState extends State<DiscoverCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            child: Icon(Icons.person),
            radius: 25,
          ),
          SizedBox(height: 16,),
          Text(
            'Hanif Aliffudin',
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20
            ),
          ),
          SizedBox(height: 2,),
          Text('175150200111060'),
          SizedBox(height: 16,),
          Text('Teknik Informatika'),
          SizedBox(height: 2  ,),
          Text('Web Developer'),
          SizedBox(height: 5,)
        ],
      ),
    );
  }
}
