import 'package:flutter/material.dart';
import 'package:flutter_app/services/authService.dart';
import 'package:settings_ui/settings_ui.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    bool lockInBackground = true;
    return Scaffold(
        body: new Stack(
          children: <Widget>[
            ClipPath(
              child: Container(color: Colors.black.withOpacity(0.8)),
              clipper: getClipper(),
            ),
            SettingsList(
                sections: [
                  SettingsSection(
                    title: 'Profile',
                    tiles: [
                      SettingsTile(
                        title: 'Joe Bidem',
                        subtitle: 'Available for Freelance',
                        leading: Icon(Icons.account_circle,size: 60,),
                        onTap: () {
//                Navigator.of(context).push(MaterialPageRoute(
//                builder: (BuildContext context) => LanguagesScreen()));
                        },
                      ),
                    ],
                  ),
                  SettingsSection(
                  title: 'Manage your profile',
                  tiles: [
                  SettingsTile(
                  title: 'Address Book',
                  leading: Icon(Icons.bookmark),
                  onTap: () {
  //                Navigator.of(context).push(MaterialPageRoute(
  //                builder: (BuildContext context) => LanguagesScreen()));
                  },
                  ),
                  SettingsTile(
                  title: 'Payment methods',
                  leading: Icon(Icons.account_balance_wallet)),
                  SettingsTile(
                      title: 'Billing details',
                      leading: Icon(Icons.account_balance)),
                  ],
                  ),
                  SettingsSection(
                  title: 'Personal details',
                  tiles: [
                      SettingsTile(title: 'Phone number', leading: Icon(Icons.phone)),
                      SettingsTile(title: 'Email', leading: Icon(Icons.email)),

                      ],
                      ),
                  SettingsSection(
                    title: 'Secutiry',
                    tiles: [
                    SettingsTile.switchTile(
                    title: 'Lock app in background',
                    leading: Icon(Icons.phonelink_lock),
                    switchValue: lockInBackground,
                    onToggle: (bool value) {
                    setState(() {
                    lockInBackground = value;
                    });
                    },
                    ),
                    SettingsTile.switchTile(
                    title: 'Use fingerprint',
                    leading: Icon(Icons.fingerprint),
                    onToggle: (bool value) {},
                    switchValue: false),
                    SettingsTile.switchTile(
                    title: 'Change password',
                    leading: Icon(Icons.lock),
                    switchValue: true,
                    onToggle: (bool value) {},
                    ),
                    ],
                    ),
                    SettingsSection(
                    title: 'Misc',
                    tiles: [
                    SettingsTile(
                    title: 'Terms of Service', leading: Icon(Icons.description)),
                    SettingsTile(
                    title: 'Open source licenses',
                    leading: Icon(Icons.collections_bookmark)),
                      SettingsTile(
                          title: 'Logout',
                          leading: Icon(Icons.exit_to_app)),
                    ],
                    )
                    ],
                    ),

          ],
        ));
  }

}

class getClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(0.0, size.height / 2.9);
    path.lineTo(size.width + 125, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }

}
