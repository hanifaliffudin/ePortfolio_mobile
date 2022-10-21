import 'package:flutter/material.dart';

class ProfileCertifications extends StatefulWidget {
  const ProfileCertifications({Key? key}) : super(key: key);

  @override
  State<ProfileCertifications> createState() => _ProfileCertificationsState();
}

class _ProfileCertificationsState extends State<ProfileCertifications> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.blue,
              minimumSize: const Size.fromHeight(50), // NEW
            ),
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Add new certificate',
                  style: TextStyle(fontSize: 20),
                ),
                Icon(Icons.add)
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: (){},
                          icon: Icon(Icons.more_horiz)
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Image(
                        image: NetworkImage('https://ceblog.s3.amazonaws.com/wp-content/uploads/2018/08/20142340/best-homepage-9.png')
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    'AAD Certification',
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Text('Earned: May 24, 2022 02:30:00')
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
