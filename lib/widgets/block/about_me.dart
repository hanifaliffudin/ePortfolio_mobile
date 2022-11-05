import 'package:flutter/material.dart';

class AboutMe extends StatefulWidget {
  const AboutMe({Key? key}) : super(key: key);

  @override
  State<AboutMe> createState() => _AboutMeState();
}

class _AboutMeState extends State<AboutMe> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Card(
        color: Colors.grey[200],
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'About Me',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ],
                      ),
                    ],
                  ),
                  IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz))
                ],
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Align(
                      child: Container(
                          padding:
                          EdgeInsets.only(right: 12, left: 10, top: 10, bottom: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            //crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi ac pharetra elit. Nullam fermentum iaculis aliquam. Donec laoreet justo vitae egestas vehicula. Mauris vitae efficitur elit. Sed in felis felis. Maecenas vestibulum iaculis diam ut iaculis. Aliquam eget pretium ante. Vestibulum vel gravida tortor, at commodo leo. Etiam accumsan quam id nunc sagittis, pulvinar bibendum leo vestibulum. Donec ac magna diam. Etiam in sodales arcu, vel ullamcorper augue. Interdum et malesuada fames ac ante ipsum primis in faucibus. Vestibulum est metus, tincidunt sed congue quis, pellentesque a enim.',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          )
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
