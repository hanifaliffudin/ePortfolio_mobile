import 'package:eportfolio/widgets/certificate_card_open.dart';
import 'package:flutter/material.dart';
import '../view/add_certificate.dart';

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
            onPressed: () {
              Navigator.push(context , MaterialPageRoute(builder: (context) => const AddCertificate()),
              );
            },
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
          child: InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>CertCardOpen()));
            },
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              child: Icon(Icons.person),
                              radius: 25,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Nafira Ramadhannis',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                Text('175150201111007'),
                                Text('11.20 PM・22 Oct 2022'),
                              ],
                            ),
                            SizedBox(width: 8,),
                          ],
                        ),
                        IconButton(
                            onPressed: (){},
                            icon: Icon(Icons.more_horiz)
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
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
          ),
        )
      ],
    );
  }
}
