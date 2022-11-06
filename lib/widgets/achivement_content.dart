import 'package:eportfolio/widgets/open_feed/certificate_card_open.dart';
import 'package:flutter/material.dart';
import '../view/add_certificate.dart';
import 'card/cert_feed_card.dart';

class AchivementContent extends StatefulWidget {
  const AchivementContent({Key? key}) : super(key: key);

  @override
  State<AchivementContent> createState() => _AchivementContentState();
}

class _AchivementContentState extends State<AchivementContent> {
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
              Navigator.push(context , MaterialPageRoute(builder: (context) => const AddCertificate()),
            );
              },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Add new certificate',
                  style: TextStyle(fontSize: 15),
                ),
                Icon(Icons.add)
              ],
            ),
          ),
        ),
        CertCard()
      ],
    );
  }
}
