import 'package:api_integration/webview_screen/wiki_article_webview.dart';
import 'package:flutter/material.dart';

List<Page> recent = [];

class SearchItem extends StatelessWidget {
  final AsyncSnapshot<List<dynamic>> snapshot;
  final int i;

  SearchItem(this.snapshot, this.i);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: () {
          int tappedPageId = snapshot.data?[i].pageId;
          Page p = new Page(
            title: snapshot.data?[i].title,
            imageURL: snapshot.data?[i].imageURL,
            description: snapshot.data?[i].description,
            pageId: snapshot.data?[i].pageId,
          );
          bool newItem = true;
          int repeatedItemIndex = 0;
          for (var item in recent) {
            if (item.pageId == p.pageId) {
              newItem = false;
              repeatedItemIndex = recent.indexOf(item);
              break;
            }
          }
          if (recent.length == 5 && newItem == true) {
            recent.removeAt(4);
            recent.insert(0, p);
          } else if (newItem == false) {
            recent.removeAt(repeatedItemIndex);
            recent.insert(0, p);
          } else if (newItem == true) {
            recent.insert(0, p);
          }

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => WikiArticleWebView(tappedPageId)));
        },
        title: Column(
          children: [
            Row(
              children: [
                Container(
                  padding:
                      EdgeInsets.only(left: 0, right: 10, top: 10, bottom: 10),
                  child: snapshot.data?[i].imageURL == ''
                      ? Container(
                          height: 50,
                          width: 50,
                          child: Image.asset('images/wikipedia.png'))
                      : new Image.network(
                          snapshot.data?[i].imageURL,
                          width: 50,
                          height: 50,
                        ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        snapshot.data?[i].title,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        snapshot.data?[i].description,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
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
  }

  List<Page> getRecent() {
    return recent;
  }
}

class Page {
  int pageId;
  String title;
  String imageURL;
  String description;

  Page(
      {required this.pageId,
      required this.title,
      required this.imageURL,
      required this.description});
}
