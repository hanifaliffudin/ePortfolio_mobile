import 'package:flutter/material.dart';

class HeaderFeedCard extends StatefulWidget {
  const HeaderFeedCard({Key? key}) : super(key: key);

  @override
  State<HeaderFeedCard> createState() => _HeaderFeedCardState();
}

class _HeaderFeedCardState extends State<HeaderFeedCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const CircleAvatar(
                backgroundImage: NetworkImage(('https://picsum.photos/200')),
                radius: 25,
              ),
              const SizedBox(width: 8,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Hanif Aliffudin',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                    ),
                  ),
                  Text('Teknik Informatika'),
                  Text('01.28 PM ・ 2 Aug 2022')
                ],
              ),
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
