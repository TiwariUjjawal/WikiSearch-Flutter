import 'package:api_integration/webview_screen/news_webview.dart';
import 'package:flutter/material.dart';

class NewsCard extends StatelessWidget {
  final String imgPath;
  final String title;
  final String url;
  final String content;
  NewsCard(this.title, this.imgPath, this.url, this.content);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 15, right: 15, top: 0, bottom: 40),
      child: InkWell(
        splashColor: Colors.brown,
        highlightColor: Colors.brown,
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => NewsWebView(url)));
        },
        child: Card(
          elevation: 30,
          shadowColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  child: Container(
                    // width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.26,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(imgPath),
                      ),
                    ),
                  )),
              Container(
                padding: const EdgeInsets.only(
                    left: 15, right: 15, top: 20, bottom: 10),
                decoration:
                    BoxDecoration(color: (Colors.black).withOpacity(0.8)),
                child: Text(
                  title,
                  style: TextStyle(fontSize: 17, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
