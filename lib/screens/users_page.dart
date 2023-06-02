import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/users.dart';
import 'user_details.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  Future<List<User>> getUsers() async{
    var url=Uri.parse("https://randomuser.me/api?results=20");
    List<User> userList=[];
    try{
      var response=await http.get(url);
      if(response.statusCode==200){
        Map userData=jsonDecode(response.body);
        List users=userData["results"];

        for(var item in users){
          var name=item['name']['first']+" "+item['name']['last'];
          var email=item['email'];
          var id=item['login']['uuid'];
          var avatar= item['picture']['large'];
          User user=User(id, name, email, avatar);
          userList.add(user);
        }
      }else{
        return Future.error("Something went wrong..!");
      }
    }catch(e)
    {
      return Future.error(e.toString());
    }
    return userList;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: getUsers(),
        builder: (BuildContext context,AsyncSnapshot snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }else {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context,int index){
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(snapshot.data[index].avatar),
                    ),
                    title: Text(snapshot.data[index].name),
                    subtitle: Text(snapshot.data[index].email),
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context)=>UserDetails(snapshot.data[index]))
                      );
                    },
                  );
                });
          }
        },
      ),
    );
  }
}
