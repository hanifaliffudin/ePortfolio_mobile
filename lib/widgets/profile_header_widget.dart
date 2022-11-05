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
      padding: EdgeInsets.only(left: 20, top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(('https://ceblog.s3.amazonaws.com/wp-content/uploads/2018/08/20142340/best-homepage-9.png')),
                    radius: 60,
                  ),
                  //SizedBox(height: 10,),
                ],
              ),
              SizedBox(width: 15,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
              )
            ],
          ),
          SizedBox(height: 130,),
          IconButton(
              onPressed: (){},
              icon: Icon(Icons.more_horiz)
          ),
        ],
      ),
    );
  }
}
