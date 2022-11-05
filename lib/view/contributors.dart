import 'package:flutter/material.dart';

class Contributors extends StatefulWidget {
  const Contributors({Key? key}) : super(key: key);

  @override
  State<Contributors> createState() => _ContributorsState();
}

class _ContributorsState extends State<Contributors> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          ),
      child: Card(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      backgroundImage: NetworkImage(('https://ceblog.s3.amazonaws.com/wp-content/uploads/2018/08/20142340/best-homepage-9.png')),
                      radius: 25,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nafira Ramadhannis',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Text('175150201111007')
                      ],
                    )
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
