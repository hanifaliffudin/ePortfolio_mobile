import 'package:flutter/material.dart';

class PersonalInformation extends StatefulWidget {
  const PersonalInformation({Key? key}) : super(key: key);
  @override
  State<PersonalInformation> createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {
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
                            'Personal Information',
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
                          padding: EdgeInsets.only(
                              right: 120, left: 10, top: 10, bottom: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                  text: TextSpan(
                                    style: DefaultTextStyle.of(context).style,
                                    children: [
                                      TextSpan(
                                        text: 'Name : ',
                                        style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(text: 'Nafira ramadhannis'),
                                    ],
                                  )),
                              RichText(
                                  text: TextSpan(
                                    style: DefaultTextStyle.of(context).style,
                                    children: [
                                      TextSpan(
                                          text: 'Student ID : ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(text: '1751502011111007'),
                                    ],
                                  )),
                              RichText(
                                  text: TextSpan(
                                    style: DefaultTextStyle.of(context).style,
                                    children: [
                                      TextSpan(
                                          text: 'Major : ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(text: 'Informatics Engineer'),
                                    ],
                                  )),
                              RichText(
                                  text: TextSpan(
                                    style: DefaultTextStyle.of(context).style,
                                    children: [
                                      TextSpan(
                                          text: 'City : ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(text: 'Tuban'),
                                    ],
                                  )),
                              RichText(
                                  text: TextSpan(
                                    style: DefaultTextStyle.of(context).style,
                                    children: [
                                      TextSpan(
                                          text: 'Date of Birth : ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(text: '01 January 2000'),
                                    ],
                                  )),
                              RichText(
                                  text: TextSpan(
                                    style: DefaultTextStyle.of(context).style,
                                    children: [
                                      TextSpan(
                                          text: 'Gender : ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(text: 'Female'),
                                    ],
                                  )),
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
