import 'package:flutter/material.dart';

class AddArticles extends StatefulWidget {
  const AddArticles({Key? key}) : super(key: key);

  @override
  State<AddArticles> createState() => _AddArticlesState();
}

class _AddArticlesState extends State<AddArticles> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: (){},
              icon: Icon(Icons.logout)
          )
        ],
        centerTitle: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('FILKOM'),
            Text(
              'Student Dashboard',
              style: TextStyle(
                  fontSize: 16
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Color(0xFFF6F6F6),
              ),
              child: Column(
                children: [
                  TextField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Heading',
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: 5,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Write articles',
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: (){},
                            icon: Icon(Icons.image),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.video_file)
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Color(0xFFF6F6F6),
              ),
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(5),
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text('Add cover image')),
                  SizedBox(height: 7,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.blue
                          ),
                          child: Text('Browse', style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 6.5, left: 6),
                        width: 295,
                        child: TextFormField(
                          decoration: new InputDecoration(
                            hintText: 'yourfilename.jpg',
                            contentPadding: EdgeInsets.all(8),
                            filled: true,
                            fillColor: Colors.white,
                            isDense: true,
                            border: new OutlineInputBorder(
                                borderSide: new BorderSide(color: Colors.grey)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.blue
                        ),
                        onPressed: () {},
                        child: Text(
                          'Add',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
