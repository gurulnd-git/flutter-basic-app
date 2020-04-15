import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/single_news_nocard.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class JobListEntries extends StatefulWidget {
  final int categoryId;
  final String name;

  JobListEntries(this.categoryId, this.name);

  @override
  _JobListEntriesState createState() => _JobListEntriesState();
}

class _JobListEntriesState extends State<JobListEntries>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  RefreshController _refreshController;
  StreamSubscription _sub;
  //List<Entry> _entries = <Entry>[];
  int _cursor = 0;

  @override
  void initState() {
    _refreshController = RefreshController(initialRefresh: false);
    //_refreshEntries();
    super.initState();
  }

  @override
  void dispose() {
    if (_sub != null) {
      _sub.cancel();
    }
    _refreshController.dispose();
    super.dispose();
  }

//  void _refreshEntries() {
//    _sub = EntryService.fetchBalebengongEntries(categoryId: widget.categoryId)
//        .asStream()
//        .listen((entries) {
//      _refreshController.refreshCompleted();
//      if (entries.isNotEmpty) {
//        setState(() {
//          _cursor = entries.last.publishedAt;
//          _entries = entries;
//        });
//      }
//    });
//    _sub.onError((err) {
//      _refreshController.refreshFailed();
//      print(err);
//    });
//  }

//  void _loadEntries() {
//    _sub = EntryService.fetchBalebengongEntries(
//        categoryId: widget.categoryId, cursor: _cursor)
//        .asStream()
//        .listen((entries) {
//      if (entries.isNotEmpty) {
//        _refreshController.loadComplete();
//        setState(() {
//          _cursor = entries.last.publishedAt;
//          _entries.addAll(entries);
//        });
//      } else {
//        _refreshController.loadNoData();
//      }
//    });
//    _sub.onError((err) {
//      _refreshController.loadNoData();
//      print(err);
//    });
//  }

  Widget _listItem(BuildContext ctx, int index) {
    return Padding(
        padding: new EdgeInsets.symmetric(horizontal: 1, vertical: 6),
        child: SingleNewsNoCard(
        key: ValueKey(2),
        showCategoryName: widget.categoryId == 0,
        showAuthor: true));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return SmartRefresher(
      controller: _refreshController,
      enablePullDown: true,
      enablePullUp: true,
      onRefresh: () {
        //_refreshEntries();
      },
      onLoading: () {
       // _loadEntries();
      },
      child: _buildList(),
    );
  }

  Widget _buildList() {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: 1,
      itemBuilder: (BuildContext ctx, int index) {
        return _listItem(ctx, index);
      },
    );
  }
}
