import 'package:flutter/material.dart';

class AddProject extends StatefulWidget {
  const AddProject({Key? key}) : super(key: key);

  @override
  State<AddProject> createState() => _AddProjectState();
}

class _AddProjectState extends State<AddProject> {
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 55,
                          backgroundColor: Colors.grey.shade200,
                          child: CircleAvatar(
                            radius: 50,
                            child: Icon(Icons.person, size: 40),
                          ),
                        ),
                        Positioned(
                          bottom: 1,
                          right: 1,
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Icon(Icons.add_a_photo, color: Colors.black),
                            ),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  width: 3,
                                  color: Colors.white,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    50,
                                  ),
                                ),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(2, 4),
                                    color: Colors.black.withOpacity(
                                      0.3,
                                    ),
                                    blurRadius: 3,
                                  ),
                                ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text('Project title:'),
                  SizedBox(height: 5,),
                  TextField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Project title',
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text('Description project:'),
                  SizedBox(height: 5,),
                  TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: 5,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Description project',
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  IconButton(
                    onPressed: (){},
                    icon: Icon(Icons.image),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Add Contributors'),
                  SizedBox(height: 5,),
                  TextField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Search by NIM/name',
                        suffixIcon: IconButton(
                            onPressed: (){},
                            icon: Icon(Icons.delete)
                        )
                    ),
                  ),
                  SizedBox(height: 5,),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                      ),
                      onPressed: () {
                      },
                      child: Align(
                        child: Icon(Icons.add),
                      )
                  ),
                  SizedBox(height: 10,),
                  Text('Project Url:'),
                  SizedBox(height: 5,),
                  TextField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Project title',
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text('Programming language:'),
                  SizedBox(height: 5,),
                  TextField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Project title',
                    ),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.blue
                        ),
                        onPressed: () {},
                        child: Text(
                          'Save',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.blue
                        ),
                        onPressed: () {},
                        child: Text(
                          'Add Project',
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
