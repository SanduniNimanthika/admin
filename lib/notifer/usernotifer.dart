import 'dart:collection';
import 'package:admin/module/user.dart';
import 'package:flutter/cupertino.dart';

class UserNotifier with ChangeNotifier {
  List<User> _userList = [];
  User _currentUser;



  UnmodifiableListView<User> get userList => UnmodifiableListView(_userList);

  User get currentUser => _currentUser;

  set userList(List<User> userlist) {
    _userList = userlist;
    notifyListeners();
  }

  set currentUser(User user) {
    _currentUser = user;
    notifyListeners();
  }


}