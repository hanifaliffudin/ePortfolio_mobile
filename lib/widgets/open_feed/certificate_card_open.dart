import 'package:flutter/material.dart';
import '../custom_appBar.dart';

class CertCardOpen extends StatefulWidget {
  const CertCardOpen({Key? key}) : super(key: key);
  @override
  State<CertCardOpen> createState() => _CertCardOpenState();
}
class _CertCardOpenState extends State<CertCardOpen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
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
                          icon: Icon(
                              Icons.more_horiz
                          )
                      )
                    ],
                  ),
                  SizedBox(height: 10,),
                  Image(image: NetworkImage('https://ceblog.s3.amazonaws.com/wp-content/uploads/2018/08/20142340/best-homepage-9.png')),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.center,
                     children: [
                       Text(
                         'AAD Certification',
                         style: TextStyle(
                           fontWeight: FontWeight.bold,
                         ),
                       ),
                       Text(
                         'Earned :  May 24. 2022 02.30'
                       )
                     ],
                   ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '     Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur id ultrices metus. Vestibulum varius eros at urna convallis porttitor. Curabitur eros lacus, pulvinar vel orci in, mollis feugiat augue. Ut risus quam, lacinia in faucibus sit amet, pretium a eros. Suspendisse nec bibendum sem. Aenean non tincidunt orci. Nunc sodales justo ac convallis ullamcorper. Nulla sollicitudin, ex vitae consectetur elementum, velit purus mollis quam, non efficitur felis lectus vitae justo. Aliquam aliquam tortor quis lorem pulvinar suscipit.',
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 230,
                    width: 250,
                    child: const Image(
                        image: NetworkImage('https://ceblog.s3.amazonaws.com/wp-content/uploads/2018/08/20142340/best-homepage-9.png',)
                    ),
                  ),
                  Text(
                    '       Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur id ultrices metus. Vestibulum varius eros at urna convallis porttitor. Curabitur eros lacus, pulvinar vel orci in, mollis feugiat augue. Ut risus quam, lacinia in faucibus sit amet, pretium a eros. Suspendisse nec bibendum sem. Aenean non tincidunt orci. Nunc sodales justo ac convallis ullamcorper. Nulla sollicitudin, ex vitae consectetur elementum, velit purus mollis quam, non efficitur felis lectus vitae justo. Aliquam aliquam tortor quis lorem pulvinar suscipit.'
                  )
                ],
              ),
            ),
          )
        ),
      )
    );
  }
}
