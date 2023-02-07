import 'package:eportfolio/services/api_service.dart';
import 'package:flutter/material.dart';
import '../config.dart';
import '../models/user_model.dart';

class SearchUser extends SearchDelegate {
  APIService _userList = APIService();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.close))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: FutureBuilder(
          future: _userList.searchUser(query: query),
          builder: (context, snapshot) {

            List<dynamic>? data = snapshot.data as List?;
            if(snapshot.hasData){
              return ListView.builder(
                  itemCount: data?.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.all(10),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/friendprofile',
                              arguments: data?[index]);
                        },
                        child: FutureBuilder<UserModel>(
                          future: APIService().fetchAnyUser(data?[index]),
                          builder: (context, snapshot){
                            if(snapshot.hasData){
                              return Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      (snapshot.data!.profilePicture == null ||
                                          snapshot.data!.profilePicture == "")
                                          ? "https://ceblog.s3.amazonaws.com/wp-content/uploads/2018/08/20142340/best-homepage-9.png"
                                          : '${Config.apiURL}/${snapshot.data!.profilePicture.toString()}',
                                    ),
                                    radius: 25,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        snapshot.data!.username ?? '',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold, fontSize: 18),
                                      ),
                                      Text(snapshot.data!.major ?? ''),
                                    ],
                                  ),
                                ],
                              );
                            } else return Container(
                            );
                          },
                        ),
                      ),
                    );
                  });
            } else return CircularProgressIndicator();
          }),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Text(
        'Discover user',
        style: TextStyle(fontWeight: FontWeight.w100),
      ),
    );
  }
}
