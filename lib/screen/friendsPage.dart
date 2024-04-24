
import "../screen/friendProfile.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "../model/friend.dart";
import "../provider/friendsList_provider.dart";

class FriendsPage extends StatefulWidget {
  const FriendsPage({super.key});

  @override
  State<FriendsPage> createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  Widget buildFriendsList(List<Friend> friendsList) {
    return ListView.builder(
      itemCount: friendsList.length,
      prototypeItem: ListTile(
        title: Text(friendsList.first.name),
      ),
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(friendsList[index].name),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Friend> friendsList = context.watch<FriendsList>().friends;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Friends"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (friendsList.isNotEmpty)
              ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: friendsList.length,
                itemBuilder: (context, index) {
                  return TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, FriendProfile.routename,
                          arguments: friendsList[index]);
                    },
                    child: Text(friendsList[index].name),
                  );
                },
              ),
            if (friendsList.isEmpty) const Text("No friends yet"),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    "/slambook",
                  );
                },
                child: Text('Go to Slambook'))
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const SizedBox(
              height: 100,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                ),
                child: Text(
                  'Navigation Drawer',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            ListTile(
              title: const Text('Friends'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/');
              },
            ),
            ListTile(
                title: const Text('Slambook'),
                onTap: () async {
                  Navigator.pushNamed(
                    context,
                    "/slambook",
                  );
                  //Navigator.pop(context);
                }),
          ],
        ),
      ),
    );
  }
}
