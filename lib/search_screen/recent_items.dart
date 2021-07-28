import 'package:api_integration/search_screen/search_item.dart';
import 'package:api_integration/webview_screen/wiki_article_webview.dart';
import 'package:flutter/material.dart';

class RecentItems extends StatefulWidget {
  final recent;

  RecentItems(this.recent);

  @override
  _RecentItemsState createState() => _RecentItemsState();
}

class _RecentItemsState extends State<RecentItems> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      child: ListView.builder(
          itemCount: recent.length,
          itemBuilder: (context, i) {
            return ListTile(
                onTap: () {
                  var tappedPageId = recent[i].pageId;
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              WikiArticleWebView(tappedPageId)));
                },
                title: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.15,
                          padding: EdgeInsets.only(
                              left: 0, right: 10, top: 10, bottom: 10),
                          child: IconButton(
                            icon: Icon(
                              Icons.history,
                              size: 40,
                              color: Colors.black54,
                            ),
                            onPressed: null,
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          margin: EdgeInsets.only(left: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                recent[i].title,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Text(
                                recent[i].description,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              recent.removeAt(i);
                            });
                          },
                          icon: Icon(
                            Icons.remove_circle,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      height: 1,
                      color: Colors.grey[400],
                    )
                  ],
                ));
          }),
    );
  }
}
