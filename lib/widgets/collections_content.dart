import 'package:eportfolio/widgets/open_feed/certificate_card_open.dart';
import 'package:flutter/material.dart';
import '../view/add_collection.dart';
import 'card/collection_feed_card.dart';

class CollectionContent extends StatefulWidget {
  const CollectionContent({Key? key}) : super(key: key);

  @override
  State<CollectionContent> createState() => _CollectionContentState();
}

class _CollectionContentState extends State<CollectionContent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.blue,
              minimumSize: const Size.fromHeight(35), // NEW
            ),
            onPressed: () {
              Navigator.push(context , MaterialPageRoute(builder: (context) => const AddCollection()),
            );
              },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Add new Collection',
                  style: TextStyle(fontSize: 15),
                ),
                Icon(Icons.add)
              ],
            ),
          ),
        ),
        CollectionCard()
      ],
    );
  }
}
