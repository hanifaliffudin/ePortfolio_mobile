import 'package:eportfolio/services/api_service.dart';
import 'package:eportfolio/view/search_user.dart';
import 'package:flutter/material.dart';
import '../config.dart';
import '../models/user_model.dart';
import '../widgets/custom_appBar.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({Key? key}) : super(key: key);
  static const routeName = '/discover';

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {

  late Future<UserModel> futureUser;

  @override
  void initState() {
    super.initState();
    futureUser = APIService().fetchAnyUser();
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: FutureBuilder<UserModel>(
          future: futureUser,
          builder: (context, snapshot){
            if(snapshot.hasData){
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 10,),
                  Text(
                    'Discover other users',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'posts, articles, and activities',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20,),
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
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Suggested users : ',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  FutureBuilder(
                    future: APIService().sugesstedUser(snapshot.data!.major, snapshot.data!.organization),
                    builder: (context, snapshot){
                      List<dynamic>? data = snapshot.data as List?;
                      if(snapshot.connectionState == ConnectionState.done && snapshot.hasData){
                        return GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          children: List.generate(data!.length, (index) {
                            return InkWell(
                              onTap: (){Navigator.pushNamed(context, '/friendprofile',
                                  arguments: data![index]);},
                              child: FutureBuilder<UserModel>(
                                future: APIService().fetchAnyUser(data[index]),
                                builder: (context, snapshot){
                                  if(snapshot.hasData){
                                    return Card(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          SizedBox(height: 10,),
                                          CircleAvatar(
                                            backgroundImage: NetworkImage(
                                              (snapshot.data!.profilePicture == null ||
                                                  snapshot.data!.profilePicture == "")
                                                  ? "https://ceblog.s3.amazonaws.com/wp-content/uploads/2018/08/20142340/best-homepage-9.png"
                                                  : '${Config.apiURL}/${snapshot.data!.profilePicture.toString()}',
                                            ),
                                            radius: 25,
                                          ),
                                          SizedBox(height: 16,),
                                          Text(
                                            snapshot.data!.username ?? '',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 20
                                            ),
                                          ),
                                          SizedBox(height: 2,),
                                          Text(snapshot.data!.nim ?? ''),
                                          SizedBox(height: 16,),
                                          Text(snapshot.data!.major ?? ''),
                                          SizedBox(height: 2  ,),
                                          Text(snapshot.data!.organization ?? ''),
                                          SizedBox(height: 5,)
                                        ],
                                      ),
                                    );
                                  } else return CircularProgressIndicator();
                                },
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
              );
            } else return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
