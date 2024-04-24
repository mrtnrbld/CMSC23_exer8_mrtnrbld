import '../provider/friendsList_provider.dart';
import '../screen/friendProfile.dart';
import '../screen/friendsPage.dart';
import '../screen/slamBook.dart';
import '../model/friend.dart';

import "package:flutter/material.dart";
import "package:provider/provider.dart";

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => FriendsList()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Friends Page",
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => FriendsPage(),
        '/slambook': (context) => SlamBook(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == FriendProfile.routename) {
          final args = settings.arguments as Friend;
          return MaterialPageRoute(builder: (context) {
            return FriendProfile(friend: args);
          });
        }
        return null;
      },
    );
  }
}
