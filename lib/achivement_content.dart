import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class Achivement extends StatefulWidget {
  const Achivement({Key? key}) : super(key: key);

  @override
  State<Achivement> createState() => _AchivementState();
}

class _AchivementState extends State<Achivement> {

  final List<Map> options =
  List.generate(10, (index) => {"id": index, "name": "Product $index"})
      .toList();

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
              /*Navigator.push(context , MaterialPageRoute(builder: (context) => const AddCollection()),
              );*/
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Add new Badges',
                  style: TextStyle(fontSize: 15),
                ),
                Icon(Icons.add)
              ],
            ),
          ),
        ),

        GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 400,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20),
            itemCount: 3,
            itemBuilder: (BuildContext ctx, index) {
              return Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                height: 100,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset: Offset(0, 2) // Shadow position
                      ),
                    ],
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(height: 15,),
                    Image.network(
                      'https://picsum.photos/300',
                      width: 100,
                      height: 100,
                      fit: BoxFit.scaleDown,
                    ),
                    SizedBox(height: 15,),
                    Text("Title jsdnfos;idahf ajhfoidafadfweff sfvwrgwf", style: TextStyle(fontWeight: FontWeight.bold),),
                    SizedBox(height: 15,),
                    Text('desc sdfsdf sdfsdfsf afnajfhiwe ashfnaefh'),
                    SizedBox(height: 15,),
                    Text('Created at : 16 Januari 2022')
                  ],
                )
              );
            }
            ),
        SizedBox(height: 5,),
      ],

    );
  }
}
