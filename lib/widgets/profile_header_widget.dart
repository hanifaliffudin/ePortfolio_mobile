import 'package:flutter/material.dart';

class ProfileHeader extends StatefulWidget {
  const ProfileHeader({Key? key}) : super(key: key);

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                child: Icon(Icons.person),
                radius: 36,
              ),
              SizedBox(height: 10,),
              Text(
                  'Hanif Aliffudin',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  )
              ),
              SizedBox(height: 5,),
              Text(
                  '175150200111060',
                  style: TextStyle(
                      fontWeight: FontWeight.w600
                  )
              ),
              SizedBox(height: 5,),
              Text('Teknik Informatika'),
              SizedBox(height: 5,),
              Text('Universitas Brawijaya'),
              SizedBox(height: 5,),
              Text('Malang'),
            ],
          ),
          IconButton(
              onPressed: (){},
              icon: Icon(Icons.more_horiz)
          )
        ],
      ),
    );
  }
}
