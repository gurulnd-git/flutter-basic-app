import 'package:flutter/material.dart';
import 'package:flutter_app/models/user.dart';

import 'package:flutter_app/services/users_services.dart';

class UsersProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

/* ------------------------------- NOTE Users ------------------------------- */
  List<User> _users = [];
  List<User> get users => _users;

  Future initState() async {
    var res = await UsersService.streamUsers();
    res.listen((r) {
      _users = r;
      notifyListeners();
    });
  }

  Future updateUser({@required User user, @required bool isRegistering}) async {
    await UsersService.updateUser(user: user, isRegistering: isRegistering);
    print('runinng');
  }

  Future updateUserPassword({User user}) async {
    await UsersService.updateUserPassword(user: user);
  }
}
