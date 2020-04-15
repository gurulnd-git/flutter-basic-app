import 'package:flutter/material.dart';
import 'package:basic_utils/basic_utils.dart';

import 'package:flutter_app/screens/single_news.dart';

class SingleNewsNoCard extends StatelessWidget {
  //final Entry entry;
  final int maxLines;
  final bool showCategoryName;
  final bool showAuthor;

  SingleNewsNoCard(
      {Key key,
        this.showCategoryName,
        this.maxLines = 3,
        this.showAuthor = false})
      : super(key: key);

  @override
  Widget build(BuildContext ctx) {
//    final categories = AppModel.of(ctx).categories;
//    final categoryName = entry.getCategoryName(categories);
//    final commentText = (entry.commentCount != null && entry.commentCount > 0)
//        ? " · ${entry.commentCount} komentar"
//        : "";
//    final subTitle = showCategoryName
//        ? "$categoryName, ${entry.formattedDate}$commentText"
//        : "${StringUtils.capitalize(entry.formattedDate)}$commentText";

    return ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 6.0),
        //isThreeLine: true,
        leading: IconButton(
          icon: Icon(Icons.directions_car),
        ) ,
//      CoverImageDecoration(
//        url: entry.cdnPicture != null ? entry.cdnPicture : entry.picture,
//        width: 70,
//        height: 50,
//        borderRadius: 5.0,
//      ),
        title: Text("Sample text",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          maxLines: maxLines,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Padding(
            padding: EdgeInsets.only(top: 3),
            child: Row(children: [
              Opacity(opacity: 0.8),
              Text(
                "subTitle",
                maxLines: 1,
                style: TextStyle(fontSize: 12),
              )
            ])),
        onTap: () {
         // _openDetail(ctx, categoryName);
        },

        trailing: Container(
          padding: EdgeInsets.only(right: 12.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                width: 60.0,
                height: 30.0,
                child: FlatButton(
                  padding: EdgeInsets.all(2),
                  color: Colors.blue,
                  textColor: Colors.white,
                  disabledColor: Colors.grey,
                  disabledTextColor: Colors.black,
                  splashColor: Colors.blueAccent,
                  onPressed: () {
                    /*...*/
                  },
                  child: Text(
                    "Endorse",
                    style: TextStyle(fontSize: 11),
                  ),
                ),
              ),

//              Container(
//
//                child: FlatButton(
//                  color: Colors.blue,
//                  textColor: Colors.white,
//                  disabledColor: Colors.grey,
//                  disabledTextColor: Colors.black,
//                  splashColor: Colors.blueAccent,
//                  onPressed: () {
//                    /*...*/
//                  },
//                  child: Text(
//                    "Endorse",
//                    style: TextStyle(fontSize: 12.0),
//                  ),
//                )
//              ),
//              Container(
//              decoration: BoxDecoration(
//                color: const Color(0xff7c94b6),
//                image: const DecorationImage(
//                  image: NetworkImage('https:///flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
//                  fit: BoxFit.cover,
//                ),
//                border: Border.all(
//                  color: Colors.black,
//                  width: 6,
//                ),
//              ),
//              child: Text("Pending")
//          ),
            ],
          ),
        )
    );
  }

  // Open detail page
//  void _openDetail(BuildContext ctx, String categoryName) {
//    Navigator.of(ctx).pushNamed(SingleNews.routeName,
//        arguments: SingleNewsArgs(categoryName, entry, showAuthor: showAuthor));
//  }
}
