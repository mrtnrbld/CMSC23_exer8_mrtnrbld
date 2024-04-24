import "package:flutter/material.dart";
import '../model/friend.dart';

class FriendsList with ChangeNotifier {
  final List<Friend> _friendsList = [];
  int friendTotal = 0;
  List<Friend> get friends => _friendsList;

  void addFriend(Friend friend) {
    _friendsList.add(friend);
    friendTotal = friendTotal + 1;
    notifyListeners();
  }

  void removeAll() {
    _friendsList.clear();
    friendTotal = 0;
    notifyListeners();
  }

  void removeFriend(String name) {
    for (int i = 0; i < _friendsList.length; i++) {
      if (_friendsList[i].name == name) {
        friendTotal = friendTotal - 1;
        _friendsList.remove(_friendsList[i]);
        break;
      }
    }
    notifyListeners();
  }
}