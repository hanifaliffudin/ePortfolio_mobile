import 'package:eportfolio/services/api_service.dart';
import 'package:eportfolio/view/search_user.dart';
import 'package:flutter/material.dart';

import '../config.dart';
import '../models/user_model.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({Key? key}) : super(key: key);

  static const routeName = '/discover';

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  late Future <List<UserModel>> futurFriend;

  @override
  void initState() {
    // TODO: implement initState
    futurFriend = APIService().getAllFriend();
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'Discover other Students',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 10,),
          TextField(
            readOnly: true,
            onTap: (){
              showSearch(context: context, delegate: SearchUser());
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Search',
              isDense: true,
            ),
          ),
          SizedBox(height: 10,),
          FutureBuilder<List<UserModel>>(
            future: futurFriend,
            builder: (context, snapshot){
              if(snapshot.connectionState == ConnectionState.done && snapshot.hasData){
                return GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  children: List.generate(snapshot.data!.length, (index) {
                    return Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                              (snapshot.data![index].profilePicture == null ||
                                  snapshot.data![index].profilePicture == "")
                                  ? "https://ceblog.s3.amazonaws.com/wp-content/uploads/2018/08/20142340/best-homepage-9.png"
                                  : '${Config.apiURL}/${snapshot.data![index].profilePicture.toString()}',
                            ),
                            radius: 25,
                          ),
                          SizedBox(height: 16,),
                          Text(
                            snapshot.data![index].username ?? '',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 20
                            ),
                          ),
                          SizedBox(height: 2,),
                          Text(snapshot.data![index].nim ?? ''),
                          SizedBox(height: 16,),
                          Text(snapshot.data![index].major ?? ''),
                          SizedBox(height: 2  ,),
                          Text('Universitas Brawijaya'),
                          SizedBox(height: 5,)
                        ],
                      ),
                    );
                  }),
                );
              } else if(
              snapshot.hasError
              ){
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 25,
                      ),
                      SizedBox(height: 10,),
                      Text('Something Went Wrong')
                    ],
                  ),
                );
              } else if(
              snapshot.connectionState == ConnectionState.waiting
              ){return CircularProgressIndicator();} return CircularProgressIndicator();
            },
          ),
        ],
      ),
    );
  }
}
