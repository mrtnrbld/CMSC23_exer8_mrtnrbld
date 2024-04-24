import 'package:flutter/material.dart';
import '../model/friend.dart';

class FriendProfile extends StatelessWidget {
  static const routename = '/friendProfile';
  
  final Friend friend;

  FriendProfile({super.key, required this.friend});

  var textFont = TextStyle(fontSize: 12);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Summary'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          ListTile(
            title: Text('Name: ${friend.name}'),
          ),
          ListTile(
            title: Text('Nickname: ${friend.nickname}'),
          ),
          ListTile(
            title: Text('Age: ${friend.age}'),
          ),
          ListTile(
            title: Text('Is Male: ${friend.isInARelationship}'),
          ),
          ListTile(
            title: Text('Happiness Level: ${friend.happiness.round().toString()}'),
          ),
          ListTile(
            title: Text('Selected Superpower: ${friend.superpower}'),
          ),
          ListTile(
            title: Text('Motto: ${friend.motto}'),
          ),
          Center(
            child: Container(
              width: 100,
              margin: EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Go back to the previous screen
                },
                child: const Text('Go Back'),
              ),
            ),
          ),
        ],
      ),
    );
  }

}