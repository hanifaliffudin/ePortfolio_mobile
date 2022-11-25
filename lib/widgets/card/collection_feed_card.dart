import 'package:flutter/material.dart';
import '../open_feed/certificate_card_open.dart';

class CollectionCard extends StatefulWidget {
  const CollectionCard({Key? key}) : super(key: key);

  @override
  State<CollectionCard> createState() => _CollectionCardState();
}

class _CollectionCardState extends State<CollectionCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: InkWell(
        onTap: (){
          //Navigator.push(context, MaterialPageRoute(builder: (context)=>CertCardOpen()));
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
                        /*CircleAvatar(
                          backgroundImage: NetworkImage(('https://picsum.photos/300')),
                          radius: 25,
                        ),*/
                        SizedBox(
                          width: 8,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('MarkdownBlock',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.blue,
                              ),
                            ),
                            Text('public',
                            style: TextStyle(
                              color: Colors.grey[400],
                            ),),
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
                  padding: EdgeInsets.only(left: 8),
                  child :Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                        "Simple blog using Next and Markdown"
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'JavaScript',
                        style: TextStyle(
                            color: Colors.grey
                        ),
                      ),
                      SizedBox(width: 20,),
                      Text('Updated on 24 May 2022',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
