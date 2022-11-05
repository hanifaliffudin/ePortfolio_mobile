import 'package:flutter/material.dart';

class NewestAct extends StatefulWidget {
  const NewestAct({Key? key}) : super(key: key);

  @override
  State<NewestAct> createState() => _NewestActState();
}

class _NewestActState extends State<NewestAct> {
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
                            'Newest Activity',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ],
                      ),
                    ],
                  ),

                ],
              ),
              SizedBox(height: 10,),
              Container(
                child: Column(
                  children: <Widget>[
                    Align(
                      child: Container(
                          padding: EdgeInsets.only(
                              right: 350, left: 10, top: 100, bottom: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            //crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //add function here
                            ],
                          )),
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 1,
                color: Colors.black,
              ),
              InkWell(
                onTap: () {DefaultTabController.of(context)?.index =1;},
                child: Text('Show all activities ->',
                style: TextStyle(
                  fontSize: 15
                ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
