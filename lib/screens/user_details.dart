
import 'package:flutter/material.dart';

import '../models/users.dart';

class UserDetails extends StatelessWidget {
  final User user;

  const UserDetails(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        titleTextStyle: const TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),
        title: Text(user.name),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(user.avatar),
              radius: 100,
            ),
            const SizedBox(
              height: 20,
            ),
            Text('Name : ${user.name}',style: const TextStyle(fontSize: 20),textWidthBasis: TextWidthBasis.longestLine,textAlign: TextAlign.center,),
            const SizedBox(
              height: 20,
            ),
            Text('Email : ${user.email}',textWidthBasis: TextWidthBasis.longestLine ,style: const TextStyle(fontSize: 20),textAlign: TextAlign.center,)
          ],
        ),
      ),
    );
  }
}
