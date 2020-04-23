import 'package:flutter/material.dart';
import 'package:flutter_app/models/user.dart';
import 'package:scoped_model/scoped_model.dart';

class AppModel extends Model {
  //List<Feed> feeds = <Feed>[];
  User currentUser;
  //RemoteConfig remoteConfig;


  void setUser(User user) {
    this.currentUser = user;
    print("currentUser SET: $user");
    notifyListeners();
  }

  static AppModel of(BuildContext ctx) =>
      ScopedModel.of<AppModel>(ctx, rebuildOnChange: false);
}
