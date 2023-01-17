import 'package:eportfolio/services/api_service.dart';
import 'package:eportfolio/widgets/box_add_post.dart';
import 'package:eportfolio/widgets/card/article_feed.dart';
import 'package:flutter/material.dart';
import 'package:eportfolio/widgets/card/post_feed.dart';

import '../config.dart';
import '../models/user_model.dart';

class Feeds extends StatefulWidget {
  const Feeds({Key? key}) : super(key: key);

  @override
  State<Feeds> createState() => _FeedsState();
}
class _FeedsState extends State<Feeds> {
  late Future<UserModel> futureUser;
  @override
  void initState() {
    // TODO: implement initState
    futureUser = APIService().fetchAnyUser();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(
        children: <Widget> [
          SizedBox(height: 10,),
          FutureBuilder<UserModel>(
            future: futureUser,
            builder: (context, snapshot){
              if(snapshot.hasData){
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 150),
                      child: Text('Selamat Datang \n${snapshot.data!.username}', style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18
                      ),),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/profile');
                      },
                      child: CircleAvatar(
                        radius: 25,
                          backgroundImage: NetworkImage(
                            (snapshot.data!.profilePicture ==
                                null ||
                                snapshot.data!.profilePicture ==
                                    "")
                                ? "https://ceblog.s3.amazonaws.com/wp-content/uploads/2018/08/20142340/best-homepage-9.png"
                                : '${Config.apiURL}/${snapshot.data!.profilePicture.toString()}',
                          )
                      ),
                    )
                  ],
                );
              } else return CircularProgressIndicator();
            },
          ),
          SizedBox(height: 5,),
          BoxAddPost(),
          ArticleFeed(),
          PostFeed(),
        ],
      ),
    );
  }
}
