import 'package:flutter/material.dart';
import 'package:flutter_app/screens/jobListEntries.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String _subscriptionTopic = 'balebengong';
  //Subscription _subscription;
  bool _showDescription = true;
  final String _spShowDescriptionKey = 'balebengong.description.show';

  @override
  void initState() {

    // Listen for auth state changes
//    AppModel.of(context).addListener(() {
//      if (!mounted) return;
//      final model = AppModel.of(context);
//      if (model.currentUser == null) {
//        setState(() {
//          _subscription = null;
//        });
//      } else {
//        _loadSubscription();
//      }
//    });
//
//    _loadSubscription();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: new Scaffold(
        appBar: new PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: new Container(
            child: new SafeArea(
              child: Column(
                children: [
                  Divider(height: 1),
                  new TabBar(
                    labelColor: Colors.black,
                    tabs: [
                      Tab(child: Text("Pending")),
                      Tab(child: Text("Accepted")),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            JobListEntries(0, "Pending"),
            JobListEntries(13, "Accepted"),
          ],
        ),
      ),
    );
  }


}
