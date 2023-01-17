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
    return FutureBuilder<List<UserModel>>(
        future: _userList.getAllUser(query: query),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          List<UserModel>? data = snapshot.data;
          return ListView.builder(
              itemCount: data?.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/friendprofile',
                              arguments: data?[index].id);
                        },
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                            (data?[index].profilePicture == null ||
                                data?[index].profilePicture == "")
                                ? "https://ceblog.s3.amazonaws.com/wp-content/uploads/2018/08/20142340/best-homepage-9.png"
                                : '${Config.apiURL}/${data?[index].profilePicture.toString()}',
                          ),
                          radius: 25,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data?[index].username ?? '',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Text(data?[index].major ?? ''),
                          /*Text(postList[index].updatedAt)*/
                        ],
                      ),
                    ],
                  ),
                );
              });
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Text('Discover user', style: TextStyle(
        fontWeight: FontWeight.w100
      ),),
    );
  }
}
