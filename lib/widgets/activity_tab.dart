import 'package:flutter/material.dart';
import '../view/add_activity.dart';
import 'card/activity_tab.dart';

class ActivityTab extends StatefulWidget {
  const ActivityTab({Key? key}) : super(key: key);

  @override
  State<ActivityTab> createState() => _ActivityTabState();
}

class _ActivityTabState extends State<ActivityTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: 5, right: 5, top: 10),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.blue,
              minimumSize: const Size.fromHeight(35), // NEW
            ),
            onPressed: () {
              Navigator.push(context , MaterialPageRoute(builder: (context) => const AddActivity()),
            );
              },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Add new Activity',
                  style: TextStyle(fontSize: 15),
                ),
                Icon(Icons.add)
              ],
            ),
          ),
        ),
        ActivityCard()
      ],
    );
  }
}
